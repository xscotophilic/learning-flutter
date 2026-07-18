import { pool, query } from "../db/index.js";
import Price from "./Price.js";

const SELECT_LINE_ITEMS = `
  SELECT oli.order_id,
         oli.product_id,
         oli.quantity,
         pr.amount,
         pr.currency,
         pr.discount_percent
  FROM order_line_items oli
  JOIN prices pr ON pr.id = oli.purchase_price_id
  WHERE oli.order_id = $1
  ORDER BY oli.id ASC
`;

const mapLineItem = (row) => ({
  product_id: row.product_id,
  quantity: row.quantity,
  purchase_price: Price.mapRow(row),
});

const mapOrderRow = (row, lineItemRows) => ({
  id: row.id.toString(),
  placed_at: row.placed_at.toISOString(),
  line_items: lineItemRows.map(mapLineItem),
});

const Order = {
  async create({ ownerId, lineItems }) {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      const { rows } = await client.query(
        "INSERT INTO orders (owner_id) VALUES ($1) RETURNING *",
        [ownerId],
      );
      const order = rows[0];

      for (const item of lineItems) {
        const priceId = await Price.insertPrice(client, item.purchase_price);
        await client.query(
          `INSERT INTO order_line_items (order_id, product_id, quantity, purchase_price_id)
           VALUES ($1, $2, $3, $4)`,
          [order.id, item.product_id, item.quantity, priceId],
        );
      }

      await client.query("COMMIT");

      const lineItemRows = await query(SELECT_LINE_ITEMS, [order.id]);
      return mapOrderRow(order, lineItemRows);
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },

  async findMostSoldProductId() {
    const rows = await query(
      `SELECT product_id, SUM(quantity) AS total_quantity
       FROM order_line_items
       GROUP BY product_id
       ORDER BY total_quantity DESC
       LIMIT 1`,
    );
    return rows[0] ? rows[0].product_id : null;
  },

  async findAllByOwnerId(ownerId) {
    const orders = await query(
      "SELECT * FROM orders WHERE owner_id = $1 ORDER BY id ASC",
      [ownerId],
    );

    const result = [];
    for (const order of orders) {
      const lineItemRows = await query(SELECT_LINE_ITEMS, [order.id]);
      result.push(mapOrderRow(order, lineItemRows));
    }

    return result;
  },
};

export default Order;
