import * as orderService from "../services/order.service.js";

export async function createOrder(req, res) {
  const {
    cart_id: cartId,
    payment_id: paymentId,
    payment_method_id: paymentMethodId,
  } = req.body;
  const order = await orderService.createOrderFromCart({
    ownerId: req.user_id,
    cartId: cartId,
    paymentId: paymentId,
    paymentMethodId: paymentMethodId,
  });

  res.status(201).json({ data: order });
}

export async function getOrders(req, res) {
  const orders = await orderService.getOrdersByOwnerId(req.user_id);

  res.status(200).json({ data: { orders } });
}
