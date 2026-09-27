import { query } from "../db/index.js";

const Favorite = {
  async findAllByUserId(userId) {
    const rows = await query(
      "SELECT product_id FROM user_favorites WHERE user_id = $1 ORDER BY created_at ASC",
      [userId],
    );
    return rows.map((row) => row.product_id);
  },

  async add(userId, productId) {
    await query(
      "INSERT INTO user_favorites (user_id, product_id) VALUES ($1, $2) ON CONFLICT DO NOTHING",
      [userId, productId],
    );
  },

  async remove(userId, productId) {
    await query(
      "DELETE FROM user_favorites WHERE user_id = $1 AND product_id = $2",
      [userId, productId],
    );
  },
};

export default Favorite;
