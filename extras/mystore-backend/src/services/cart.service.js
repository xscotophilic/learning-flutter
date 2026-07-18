import Cart from "../models/Cart.js";
import Product from "../models/Product.js";
import ApiError from "../utils/ApiError.js";

export async function getOrCreateActiveCart(ownerId) {
  let cart = await Cart.findActiveByOwnerId(ownerId);

  if (!cart) {
    cart = await Cart.create({ ownerId });
  }

  return cart;
}

export async function updateCartItem({ userId, cartId, productId, quantity }) {
  const existingCart = await Cart.findById(cartId);
  if (!existingCart) {
    throw new ApiError(404, "Cart not found");
  }

  if (existingCart.owner_id !== userId) {
    throw new ApiError(403, "Permission denied");
  }

  let unitPrice;
  if (quantity > 0) {
    const product = await Product.findById(productId);
    if (!product) {
      throw new ApiError(404, "Product not found");
    }
    unitPrice = product.price;
  }

  return Cart.upsertItem({ cartId, productId, unitPrice, quantity });
}
