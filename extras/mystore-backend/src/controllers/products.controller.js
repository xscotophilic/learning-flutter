import * as productService from "../services/product.service.js";

export async function getHeroProduct(req, res) {
  const product = await productService.getHeroProduct();

  res.status(200).json({ data: product });
}

export async function getFeaturedProducts(req, res) {
  const products = await productService.getFeaturedProducts();

  res.status(200).json({ data: { products } });
}

export async function getProductsByIds(req, res) {
  const { ids } = req.body;
  const products = await productService.getProductsByIds(ids);

  res.status(200).json({ data: { products } });
}

export async function getMyProducts(req, res) {
  const products = await productService.getMyProducts(req.user_id);

  res.status(200).json({ data: { products } });
}

export async function createProduct(req, res) {
  const { name, description, price, image_url: imageUrl } = req.body;

  const product = await productService.createProduct({
    name,
    description,
    price,
    imageUrl,
    creatorId: req.user_id,
  });

  res.status(201).json({ data: product });
}

export async function updateProduct(req, res) {
  const { name, description, price, image_url: imageUrl } = req.body;

  const product = await productService.updateProduct(
    req.params.id,
    req.user_id,
    {
      name,
      description,
      price,
      imageUrl,
    },
  );

  res.status(200).json({ data: product });
}

export async function deleteProduct(req, res) {
  await productService.deleteProduct(req.params.id, req.user_id);

  res.status(200).json({ data: null });
}
