import { pool, query } from "../db/index.js";
import Price from "./Price.js";

const SELECT_PRODUCT = `
  SELECT p.id,
         p.name,
         p.description,
         p.image_url,
         p.creator_id,
         p.price_id,
         pr.amount,
         pr.currency,
         pr.discount_percent
  FROM products p
  JOIN prices pr ON pr.id = p.price_id
`;

const mapRow = (row) => ({
  id: row.id.toString(),
  name: row.name,
  description: row.description,
  price: Price.mapRow(row),
  image_url: row.image_url,
  creator_id: row.creator_id,
});

const Product = {
  async findLatest() {
    const rows = await query(`${SELECT_PRODUCT} ORDER BY p.id DESC LIMIT 1`);
    return rows[0] ? mapRow(rows[0]) : null;
  },

  async findAll() {
    const rows = await query(`${SELECT_PRODUCT} ORDER BY p.id ASC`);
    return rows.map(mapRow);
  },

  async findById(id) {
    const numericId = parseInt(id, 10);
    if (Number.isNaN(numericId)) return null;

    const rows = await query(`${SELECT_PRODUCT} WHERE p.id = $1`, [numericId]);
    return rows[0] ? mapRow(rows[0]) : null;
  },

  async findByIds(ids) {
    const numericIds = (ids || [])
      .map((id) => parseInt(id, 10))
      .filter((id) => !Number.isNaN(id));

    if (numericIds.length === 0) return [];

    const rows = await query(`${SELECT_PRODUCT} WHERE p.id = ANY($1::int[])`, [
      numericIds,
    ]);
    return rows.map(mapRow);
  },

  async findAllByCreatorId(creatorId) {
    const rows = await query(
      `${SELECT_PRODUCT} WHERE p.creator_id = $1 ORDER BY p.id ASC`,
      [creatorId],
    );
    return rows.map(mapRow);
  },

  async create({ name, description, price, imageUrl, creatorId }) {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      const priceId = await Price.insertPrice(client, price);

      const { rows } = await client.query(
        `INSERT INTO products (name, description, price_id, image_url, creator_id)
         VALUES ($1, $2, $3, $4, $5)
         RETURNING id`,
        [name, description, priceId, imageUrl, creatorId],
      );

      await client.query("COMMIT");

      return this.findById(rows[0].id);
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },

  async updateById(id, { name, description, price, imageUrl }) {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      const { rows: existingRows } = await client.query(
        "SELECT * FROM products WHERE id = $1 FOR UPDATE",
        [id],
      );
      const existing = existingRows[0];
      if (!existing) {
        await client.query("ROLLBACK");
        return null;
      }

      if (price) {
        await Price.updatePrice(client, existing.price_id, price);
      }

      await client.query(
        `UPDATE products
         SET name = COALESCE($1, name),
             description = COALESCE($2, description),
             image_url = COALESCE($3, image_url),
             updated_at = now()
         WHERE id = $4`,
        [name, description, imageUrl, id],
      );

      await client.query("COMMIT");

      return this.findById(id);
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },

  async deleteById(id) {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      const { rows } = await client.query(
        "SELECT price_id FROM products WHERE id = $1",
        [id],
      );
      const priceId = rows[0]?.price_id;

      await client.query("DELETE FROM products WHERE id = $1", [id]);

      if (priceId) {
        await Price.deletePrice(client, priceId);
      }

      await client.query("COMMIT");
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },
};

export default Product;
