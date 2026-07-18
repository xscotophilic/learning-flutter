import { pool, query } from "../db/index.js";
import Price from "./Price.js";

const SELECT_ITEMS = `
  SELECT ci.id,
         ci.product_id,
         ci.quantity,
         ci.unit_price_id,
         pr.amount,
         pr.currency,
         pr.discount_percent
  FROM cart_items ci
  JOIN prices pr ON pr.id = ci.unit_price_id
  WHERE ci.cart_id = $1
  ORDER BY ci.id ASC
`;

const mapCartRow = (row, items) => ({
  id: row.id.toString(),
  owner_id: row.owner_id,
  created_at: row.created_at.toISOString(),
  status: row.status,
  items,
  total: {
    subtotal: Number(row.total_subtotal),
    discount: Number(row.total_discount),
    total: Number(row.total_amount),
    currency: row.total_currency,
  },
});

const getItemRows = async (cartId) => query(SELECT_ITEMS, [cartId]);

const mapItem = (row) => ({
  product_id: row.product_id.toString(),
  unit_price: Price.mapRow(row),
  quantity: row.quantity,
});

const Cart = {
  async findActiveByOwnerId(ownerId) {
    const rows = await query(
      `SELECT * FROM carts WHERE owner_id = $1 AND status = 'active'
       ORDER BY id DESC LIMIT 1`,
      [ownerId],
    );
    if (!rows[0]) return null;

    const itemRows = await getItemRows(rows[0].id);
    return mapCartRow(rows[0], itemRows.map(mapItem));
  },

  async create({ ownerId }) {
    const rows = await query(
      `INSERT INTO carts (owner_id) VALUES ($1) RETURNING *`,
      [ownerId],
    );
    return mapCartRow(rows[0], []);
  },

  async findById(id) {
    const numericId = parseInt(id, 10);
    if (Number.isNaN(numericId)) return null;

    const rows = await query("SELECT * FROM carts WHERE id = $1", [
      numericId,
    ]);
    if (!rows[0]) return null;

    const itemRows = await getItemRows(numericId);
    return mapCartRow(rows[0], itemRows.map(mapItem));
  },

  async upsertItem({ cartId, productId, unitPrice, quantity }) {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      const { rows: existingRows } = await client.query(
        "SELECT * FROM cart_items WHERE cart_id = $1 AND product_id = $2 FOR UPDATE",
        [cartId, productId],
      );
      const existing = existingRows[0];

      if (quantity <= 0) {
        if (existing) {
          await client.query("DELETE FROM cart_items WHERE id = $1", [
            existing.id,
          ]);
          await Price.deletePrice(client, existing.unit_price_id);
        }
      } else if (existing) {
        await Price.updatePrice(client, existing.unit_price_id, unitPrice);
        await client.query(
          "UPDATE cart_items SET quantity = $1 WHERE id = $2",
          [quantity, existing.id],
        );
      } else {
        const priceId = await Price.insertPrice(client, unitPrice);
        await client.query(
          `INSERT INTO cart_items (cart_id, product_id, unit_price_id, quantity)
           VALUES ($1, $2, $3, $4)`,
          [cartId, productId, priceId, quantity],
        );
      }

      await client.query("COMMIT");
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }

    return this._recalculateTotal(cartId);
  },

  async _recalculateTotal(cartId) {
    const itemRows = await getItemRows(cartId);

    let amount = 0;
    let discount = 0;
    let currency = null;

    for (const row of itemRows) {
      const unitAmount = Number(row.amount);
      const unitCurrency = row.currency;
      const discountPercent = Number(row.discount_percent) || 0;

      if (currency === null) {
        currency = unitCurrency;
      } else if (currency !== unitCurrency) {
        currency = "invalid";
      }

      const currentItemAmount = unitAmount * row.quantity;
      const currentItemDiscount =
        discountPercent <= 0 ? 0 : (discountPercent / 100) * currentItemAmount;

      amount += currentItemAmount;
      discount += currentItemDiscount;
    }

    const rows = await query(
      `UPDATE carts
       SET total_subtotal = $1, total_discount = $2, total_amount = $3,
           total_currency = $4, updated_at = now()
       WHERE id = $5
       RETURNING *`,
      [amount, discount, amount - discount, currency || "", cartId],
    );

    return mapCartRow(rows[0], itemRows.map(mapItem));
  },

  async updateStatus(id, status) {
    await query(
      `UPDATE carts SET status = $1, updated_at = now() WHERE id = $2`,
      [status, id],
    );
  },
};

export default Cart;
