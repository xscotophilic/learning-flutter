import 'package:flutter/material.dart';
import 'package:my_store/providers/product.dart';

List<Product> globalProducts = [
  Product(
    id: 'p1',
    title: 'Warm Whiff Candle',
    description:
        'A cozy, slow-burning candle with soft amber notes and a calming woody finish. Designed to turn any space into a warm escape.',
    price: 14.99,
    imageURL: 'https://imglink.cc/cdn/0mcnRDtEx_.png',
    color: const Color(0xFFe8d8c3),
  ),
  Product(
    id: 'p2',
    title: 'Chips by Just One More',
    description:
        'Thin, crispy, dangerously addictive chips. One bite in, and the name starts making sense.',
    price: 2.99,
    imageURL: 'https://imglink.cc/cdn/TOLCciwlz7.png',
    color: const Color(0xFFf5d27a),
  ),
  Product(
    id: 'p3',
    title: 'Coffee by Bean There',
    description:
        'Rich, smooth roasted coffee with bold aroma and balanced acidity. Crafted for people who take their mornings seriously.',
    price: 9.49,
    imageURL: 'https://imglink.cc/cdn/d8f36WXxZl.png',
    color: const Color(0xFFc4a484),
  ),
  Product(
    id: 'p4',
    title: 'Ruby Rush Pomegranate Juice',
    description:
        'A vibrant burst of real pomegranate with a naturally sweet-tart punch. Pure, refreshing, and full of life.',
    price: 3.99,
    imageURL: 'https://imglink.cc/cdn/p1e5nlicKs.png',
    color: const Color(0xFFd94b4b),
  ),
  Product(
    id: 'p5',
    title: 'Rustico Pasta Co. - Tortellini',
    description:
        'Authentic Italian-style tortellini with a rustic touch. Perfect texture, rich flavor, and made for comfort meals.',
    price: 6.49,
    imageURL: 'https://imglink.cc/cdn/gXaBS9fkHm.png',
    color: const Color(0xFFf0d9a7),
  ),
  Product(
    id: 'p6',
    title: 'Glowshield Sunscreen',
    description:
        'Lightweight, non-greasy sunscreen that protects and hydrates. Built for daily wear with a clean, invisible finish.',
    price: 11.99,
    imageURL: 'https://imglink.cc/cdn/Ejubs1dENg.png',
    color: const Color(0xFFe6f3f7),
  ),
];
