-- Seed demo products owned by the admin user (id = '00000000-0000-0000-0000-000000000099').
-- Uses CTEs to insert prices and immediately reference their UUIDs in products.

WITH p1 AS (
  INSERT INTO prices (amount, currency, discount_percent)
  VALUES (18.00, 'USD', 10)
  RETURNING id
)
INSERT INTO products (name, description, price_id, image_url, creator_id)
SELECT
  'Peanut Butter Cookie',
  'A rich, indulgent cookie packed with creamy peanut butter flavor in every bite. Perfectly crisp on the edges with a soft, chewy center that melts in your mouth. Made with premium roasted peanut butter and a touch of vanilla for extra depth. The classic crosshatch pattern ensures even baking throughout. A timeless treat loved by peanut butter fans of all ages.',
  p1.id,
  'https://i.ibb.co/jBNW3CC/peanut-butter-cookie.webp',
  '00000000-0000-0000-0000-000000000099'
FROM p1;

WITH p2 AS (
  INSERT INTO prices (amount, currency, discount_percent)
  VALUES (20.00, 'USD', 10)
  RETURNING id
)
INSERT INTO products (name, description, price_id, image_url, creator_id)
SELECT
  'Oatmeal Raisin Cookie',
  'A wholesome, hearty cookie loaded with plump, juicy raisins and rolled oats. Warmly spiced with cinnamon and a hint of nutmeg for that cozy, homemade aroma. Each bite delivers a satisfying chew from thick oats and naturally sweet raisins. Baked to golden perfection with crisp edges and a tender, soft interior. A classic comfort cookie that feels like a warm hug with every single bite.',
  p2.id,
  'https://i.ibb.co/Q79ByhmD/oatmeal-raisin-cookie.webp',
  '00000000-0000-0000-0000-000000000099'
FROM p2;

WITH p3 AS (
  INSERT INTO prices (amount, currency)
  VALUES (14.00, 'USD')
  RETURNING id
)
INSERT INTO products (name, description, price_id, image_url, creator_id)
SELECT
  'Snickerdoodle',
  'A beloved classic rolled generously in a fragrant cinnamon-sugar coating before baking. Soft, pillowy, and slightly tangy thanks to a touch of cream of tartar in the dough. The warm cinnamon crust gives way to a melt-in-your-mouth, buttery soft center. Simple yet irresistible, this cookie fills the room with a comforting, spiced aroma. Perfect for sharing; though once you start, stopping is nearly impossible.',
  p3.id,
  'https://i.ibb.co/whXG6Y2w/snickerdoodle.webp',
  '00000000-0000-0000-0000-000000000099'
FROM p3;

WITH p4 AS (
  INSERT INTO prices (amount, currency, discount_percent)
  VALUES (10.00, 'USD', 10)
  RETURNING id
)
INSERT INTO products (name, description, price_id, image_url, creator_id)
SELECT
  'Choco Chip Cookie',
  'The ultimate crowd-pleaser, loaded with generous pockets of rich semi-sweet chocolate chips. Golden-brown and perfectly crisp on the outside with a gooey, soft center inside. Made with brown butter and a blend of sugars for deep caramel-like undertones. Every bite guarantees melty chocolate in every single mouthful, no dry spots here. The cookie that started it all, and still the one everyone reaches for first.',
  p4.id,
  'https://i.ibb.co/9mS5StLX/choco-chip-cookie.webp',
  '00000000-0000-0000-0000-000000000099'
FROM p4;

WITH p5 AS (
  INSERT INTO prices (amount, currency)
  VALUES (16.00, 'USD')
  RETURNING id
)
INSERT INTO products (name, description, price_id, image_url, creator_id)
SELECT
  'Shortbread Cookie',
  'An elegant, buttery cookie with a delicate crumb that simply dissolves on the tongue. Made with just a few quality ingredients - real butter, flour, and a whisper of sugar. Its simplicity is its strength, letting the rich, creamy butter flavor truly shine. Lightly golden with a satisfying snap, it pairs beautifully with tea or coffee. A refined, timeless classic that proves the finest things in life are often the simplest.',
  p5.id,
  'https://i.ibb.co/Kz7NyDpH/shortbread-cookie.webp',
  '00000000-0000-0000-0000-000000000099'
FROM p5;

WITH p6 AS (
  INSERT INTO prices (amount, currency)
  VALUES (12.00, 'USD')
  RETURNING id
)
INSERT INTO products (name, description, price_id, image_url, creator_id)
SELECT
  'Molasses Cookie',
  'A bold, deeply spiced cookie made with rich blackstrap molasses for intense, complex flavor. Infused with a warming blend of ginger, cloves, and cinnamon in every single bite. The molasses keeps these cookies incredibly soft and chewy for days after baking. Rolled in sugar before baking for a sparkly, slightly crisp exterior that contrasts beautifully. A festive favorite that brings warmth and spice to any cookie jar or dessert spread.',
  p6.id,
  'https://i.ibb.co/Z6QhWxHG/molasses-cookie.webp',
  '00000000-0000-0000-0000-000000000099'
FROM p6;
