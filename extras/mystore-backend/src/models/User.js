import { query } from "../db/index.js";

const mapRow = (row) => ({
  id: row.id,
  google_sub: row.google_sub,
  email: row.email,
  name: row.name,
  picture: row.picture,
  created_at: row.created_at.toISOString(),
  updated_at: row.updated_at.toISOString(),
});

const User = {
  async findByGoogleSub(googleSub) {
    const rows = await query("SELECT * FROM users WHERE google_sub = $1", [
      googleSub,
    ]);
    return rows[0] ? mapRow(rows[0]) : null;
  },

  async create({ googleSub, email, name, picture }) {
    const rows = await query(
      `INSERT INTO users (google_sub, email, name, picture)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [googleSub, email, name ?? null, picture ?? null],
    );
    return mapRow(rows[0]);
  },

  async findOrCreateByGoogleProfile({ googleSub, email, name, picture }) {
    const existing = await User.findByGoogleSub(googleSub);
    if (existing) return existing;
    return User.create({ googleSub, email, name, picture });
  },
};

export default User;
