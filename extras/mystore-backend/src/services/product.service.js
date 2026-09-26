import Product from "../models/Product.js";
import Order from "../models/Order.js";
import ApiError from "../utils/ApiError.js";

export async function getHeroProduct() {
  const mostSoldProductId = await Order.findMostSoldProductId();

  const product = mostSoldProductId
    ? await Product.findById(mostSoldProductId)
    : null;

  const heroProduct = product || (await Product.findLatest());

  if (!heroProduct) {
    throw new ApiError(404, "No products found");
  }

  return heroProduct;
}

export async function getFeaturedProducts() {
  return Product.findAll();
}

export async function getProductsByIds(ids) {
  return Product.findByIds(ids);
}

export async function getMyProducts(creatorId) {
  return Product.findAllByCreatorId(creatorId);
}

export async function createProduct({
  name,
  description,
  price,
  imageUrl,
  creatorId,
}) {
  if (
    name == null ||
    description == null ||
    price == null ||
    imageUrl == null
  ) {
    throw new ApiError(400, "Invalid product data");
  }

  return Product.create({ name, description, price, imageUrl, creatorId });
}

export async function updateProduct(
  id,
  userId,
  { name, description, price, imageUrl },
) {
  const existingProduct = await Product.findById(id);

  if (!existingProduct) {
    throw new ApiError(404, "Product not found");
  }

  if (existingProduct.creator_id !== userId) {
    throw new ApiError(403, "Permission denied");
  }

  return Product.updateById(id, { name, description, price, imageUrl });
}

export async function deleteProduct(id, userId) {
  const existingProduct = await Product.findById(id);

  if (!existingProduct) {
    throw new ApiError(404, "Product not found");
  }

  if (existingProduct.creator_id !== userId) {
    throw new ApiError(403, "Permission denied");
  }

  await Product.deleteById(id);
}
