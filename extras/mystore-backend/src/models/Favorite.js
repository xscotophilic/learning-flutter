import { query } from "../db/index.js";

const Favorite = {
  async findAllByUserId(userId) {
    const rows = await query(
      "SELECT product_id FROM user_favorites WHERE user_id = $1 ORDER BY created_at ASC",
      [userId],
    );
    return rows.map((row) => row.product_id.toString());
  },

  async add(userId, productId) {
    const numericProductId = parseInt(productId, 10);
    if (Number.isNaN(numericProductId)) {
      throw new Error("Invalid product ID");
    }
    await query(
      "INSERT INTO user_favorites (user_id, product_id) VALUES ($1, $2) ON CONFLICT DO NOTHING",
      [userId, numericProductId],
    );
  },

  async remove(userId, productId) {
    const numericProductId = parseInt(productId, 10);
    if (Number.isNaN(numericProductId)) {
      throw new Error("Invalid product ID");
    }
    await query(
      "DELETE FROM user_favorites WHERE user_id = $1 AND product_id = $2",
      [userId, numericProductId],
    );
  },
};

export default Favorite;
