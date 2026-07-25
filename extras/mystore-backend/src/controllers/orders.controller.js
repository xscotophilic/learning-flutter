import * as orderService from "../services/order.service.js";

export async function createOrder(req, res) {
  const { cart_id, payment_id, payment_method_id } = req.body;
  const order = await orderService.createOrderFromCart({
    ownerId: req.user_id,
    cartId: cart_id,
    paymentId: payment_id,
    paymentMethodId: payment_method_id,
  });

  res.status(201).json({ data: order });
}

export async function getOrders(req, res) {
  const orders = await orderService.getOrdersByOwnerId(req.user_id);

  res.status(200).json({ data: { orders } });
}
