import * as cartService from "../services/cart.service.js";

export async function getCart(req, res) {
  const cart = await cartService.getOrCreateActiveCart(req.user_id);

  res.status(200).json({ data: { cart } });
}

export async function updateCartItem(req, res) {
  const { cart_id: cartId, product_id: productId, quantity } = req.body;

  const cart = await cartService.updateCartItem({
    userId: req.user_id,
    cartId,
    productId,
    quantity,
  });

  res.status(200).json({ data: { cart } });
}
