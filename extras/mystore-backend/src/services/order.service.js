import Cart from "../models/Cart.js";
import Order from "../models/Order.js";
import ApiError from "../utils/ApiError.js";

export async function createOrderFromCart(ownerId) {
  const cart = await Cart.findActiveByOwnerId(ownerId);

  if (!cart || cart.status === "completed") {
    throw new ApiError(400, "Invalid cart");
  }

  const lineItems = cart.items.map((item) => ({
    product_id: item.product_id,
    quantity: item.quantity,
    purchase_price: item.unit_price,
  }));

  const order = await Order.create({ ownerId, lineItems });

  await Cart.updateStatus(cart.id, "completed");

  return order;
}

export async function getOrdersByOwnerId(ownerId) {
  return Order.findAllByOwnerId(ownerId);
}
