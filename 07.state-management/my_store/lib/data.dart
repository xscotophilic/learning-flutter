import 'package:flutter/material.dart';

import 'providers/product.dart';

List<Product> PRODUCTS = [
  Product(
    id: 'p1',
    title: 'Rick T-shirt',
    description: 'Rick Sanchez is a drunk, deeply depressed man-god.',
    price: 5.99,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/122718310-695db200-d28a-11eb-8428-56548c06b4fb.png',
    color: Color(0xFF636363),
  ),
  Product(
    id: 'p2',
    title: 'Morty T-shirt',
    description:
        'He is the grandson of Rick and is often forced to tag along on his various misadventures.',
    price: 5.99,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/122718311-69f64880-d28a-11eb-90a6-11ca60d90f6e.png',
    color: Color(0xFF636363),
  ),
  Product(
    id: 'p3',
    title: 'Honey',
    description: 'as it exists in the beehive.',
    price: 10.00,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/122718315-6a8edf00-d28a-11eb-9bbf-3a4abbea77de.png',
    color: Color(0xFFf5cbb6),
  ),
  Product(
    id: 'p4',
    title: 'Blue Beans',
    description: 'No one knows what\'s in it. It\'s Coffee maybe.',
    price: 8.49,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/122718316-6b277580-d28a-11eb-8e45-80bf302627c8.png',
    color: Color(0xFFe2d2c4),
  ),
  Product(
    id: 'p5',
    title: 'Ice cream?',
    description:
        'If you\'re looking for a tart and refreshing frozen treat that tastes like legit fruit, grab a spoon and dig into this pint from the "Ice Cream?".',
    price: 2.50,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/122718321-6bc00c00-d28a-11eb-9ec8-6feae43921dd.png',
    color: Color(0xFFedb5d1),
  ),
  Product(
    id: 'p6',
    title: 'Mango',
    description: 'A simple, delicious and refreshing Beer for any occasion.',
    price: 12.99,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/122718323-6c58a280-d28a-11eb-91e8-b8d660eb5e3b.png',
    color: Color(0xFFf1c983),
  ),
];
