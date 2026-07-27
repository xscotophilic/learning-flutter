import Cart from "../models/Cart.js";
import Order from "../models/Order.js";
import ApiError from "../utils/ApiError.js";

export async function createOrderFromCart({
  ownerId,
  cartId,
  paymentId,
  paymentMethodId,
}) {
  const cart = await Cart.findById(cartId);

  if (!cart || cart.status === "completed" || cart.owner_id !== ownerId) {
    throw new ApiError(400, "Invalid cart");
  }

  const lineItems = cart.items.map((item) => ({
    product_id: item.product_id,
    quantity: item.quantity,
    purchase_price: item.unit_price,
  }));

  const order = await Order.create({
    ownerId,
    lineItems,
    paymentId,
    paymentMethodId,
  });

  await Cart.updateStatus(cart.id, "completed");

  return order;
}

export async function getOrdersByOwnerId(ownerId) {
  return Order.findAllByOwnerId(ownerId);
}
