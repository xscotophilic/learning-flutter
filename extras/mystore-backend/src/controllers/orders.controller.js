import * as orderService from "../services/order.service.js";

export async function createOrder(req, res) {
  const order = await orderService.createOrderFromCart(req.user_id);

  res.status(201).json({ data: order });
}

export async function getOrders(req, res) {
  const orders = await orderService.getOrdersByOwnerId(req.user_id);

  res.status(200).json({ data: { orders } });
}
