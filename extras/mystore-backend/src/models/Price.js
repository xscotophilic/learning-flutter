const priceValues = (price) => [
  price.amount,
  price.currency,
  price.discount_percent ?? null,
];

const Price = {
  async insertPrice(client, price) {
    const { rows } = await client.query(
      `INSERT INTO prices (amount, currency, discount_percent)
       VALUES ($1, $2, $3)
       RETURNING id`,
      priceValues(price),
    );
    return rows[0].id;
  },

  async updatePrice(client, priceId, price) {
    await client.query(
      `UPDATE prices SET amount = $1, currency = $2, discount_percent = $3
       WHERE id = $4`,
      [...priceValues(price), priceId],
    );
  },

  async deletePrice(client, priceId) {
    await client.query("DELETE FROM prices WHERE id = $1", [priceId]);
  },

  mapRow(row) {
    const amount = Number(row.amount);
    const currency = row.currency;
    const discountPercent = row.discount_percent;

    const result = { amount, currency };

    if (discountPercent != null && Number(discountPercent) > 0) {
      result.discount_percent = Number(discountPercent);
    }

    return result;
  },
};

export default Price;
