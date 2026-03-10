import 'package:flutter/material.dart';

import 'package:appetite_assorted/models/category.dart';
import 'package:appetite_assorted/models/meal.dart';

const Color color_one = Color(0xFFfbd4f2);
const Color color_two = Color(0xFFa5d8ff);
const Color color_three = Color(0xFF3B72FF);

const FOOD_CATEGORIES = const [
  Category(
    id: 'c1',
    title: 'Italian',
    color: color_three,
    image: 'assets/images/categories/Italian.png',
  ),
  Category(
    id: 'c2',
    title: 'Quick & Easy',
    color: color_three,
    image: 'assets/images/categories/Quick.png',
  ),
  Category(
    id: 'c3',
    title: 'Summer',
    color: color_three,
    image: 'assets/images/categories/Summer.png',
  ),
  Category(
    id: 'c4',
    title: 'German',
    color: color_three,
    image: 'assets/images/categories/German.png',
  ),
  Category(
    id: 'c5',
    title: 'Light & Lovely',
    color: color_three,
    image: 'assets/images/categories/Light.png',
  ),
  Category(
    id: 'c6',
    title: 'Exotic',
    color: color_three,
    image: 'assets/images/categories/Exotic.png',
  ),
  Category(
    id: 'c7',
    title: 'Breakfast',
    color: color_three,
    image: 'assets/images/categories/Breakfast.png',
  ),
  Category(
    id: 'c8',
    title: 'Asian',
    color: color_three,
    image: 'assets/images/categories/Asian.png',
  ),
  Category(
    id: 'c9',
    title: 'French',
    color: color_three,
    image: 'assets/images/categories/French.png',
  ),
  Category(
    id: 'c10',
    title: 'Hamburgers',
    color: color_three,
    image: 'assets/images/categories/Hamburgers.png',
  ),
];

const FOOD_MEALS = const [
  Meal(
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    title: 'Spaghetti with Tomato Sauce',
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121798854-4dcd2880-cc46-11eb-8e60-afc484e667d2.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121798854-4dcd2880-cc46-11eb-8e60-afc484e667d2.png',
    duration: 20,
    ingredients: [
      '4 Tomatoes',
      '1 Tablespoon of Olive Oil',
      '1 Onion',
      '250g Spaghetti',
      'Spices',
      'Cheese (optional)'
    ],
    steps: [
      'Cut the tomatoes and the onion into small pieces.',
      'Boil some water - add salt to it once it boils.',
      'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.',
      'In the meantime, heaten up some olive oil and add the cut onion.',
      'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.',
      'The sauce will be done once the spaghetti are.',
      'Feel free to add some cheese on top of the finished dish.'
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm2',
    categories: [
      'c2',
    ],
    title: 'Toast Hawaii',
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121797824-502c8400-cc40-11eb-8d7b-6b1a3df4aed2.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121797824-502c8400-cc40-11eb-8d7b-6b1a3df4aed2.png',
    duration: 10,
    ingredients: [
      '1 Slice White Bread',
      '1 Slice Ham',
      '1 Slice Pineapple',
      '1-2 Slices of Cheese',
      'Butter'
    ],
    steps: [
      'Butter one side of the white bread',
      'Layer ham, the pineapple and cheese on the white bread',
      'Bake the toast for round about 10 minutes in the oven at 200°C'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm3',
    categories: [
      'c2',
      'c10',
    ],
    title: 'Classic Hamburger',
    affordability: Affordability.Pricey,
    complexity: Complexity.Simple,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121798842-47d74780-cc46-11eb-9593-de41bdc7268c.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121797814-4acf3980-cc40-11eb-9fba-cb205268883d.png',
    duration: 45,
    ingredients: [
      '300g Cattle Hack',
      '1 Tomato',
      '1 Cucumber',
      '1 Onion',
      'Ketchup',
      '2 Burger Buns'
    ],
    steps: [
      'Form 2 patties',
      'Fry the patties for c. 4 minutes on each side',
      'Quickly fry the buns for c. 1 minute on each side',
      'Bruch buns with ketchup',
      'Serve burger with tomato, cucumber and onion'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm4',
    categories: [
      'c4',
    ],
    title: 'Wiener Schnitzel',
    affordability: Affordability.Luxurious,
    complexity: Complexity.Challenging,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/122035834-827ce380-cdf0-11eb-8e1d-e01af8fde950.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/122035834-827ce380-cdf0-11eb-8e1d-e01af8fde950.png',
    duration: 60,
    ingredients: [
      '8 Veal Cutlets',
      '4 Eggs',
      '200g Bread Crumbs',
      '100g Flour',
      '300ml Butter',
      '100g Vegetable Oil',
      'Salt',
      'Lemon Slices'
    ],
    steps: [
      'Tenderize the veal to about 2–4mm, and salt on both sides.',
      'On a flat plate, stir the eggs briefly with a fork.',
      'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.',
      'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.',
      'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes ‘fluffy’.',
      'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.',
      'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm5',
    categories: [
      'c2',
      'c5',
      'c3',
    ],
    title: 'Salad with Smoked Salmon',
    affordability: Affordability.Luxurious,
    complexity: Complexity.Simple,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121798853-4d349200-cc46-11eb-8d64-2201be7c3979.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121797822-4efb5700-cc40-11eb-8aca-331ca98176bc.png',
    duration: 15,
    ingredients: [
      'Arugula',
      'Lamb\'s Lettuce',
      'Parsley',
      'Fennel',
      '200g Smoked Salmon',
      'Mustard',
      'Balsamic Vinegar',
      'Olive Oil',
      'Salt and Pepper'
    ],
    steps: [
      'Wash and cut salad and herbs',
      'Dice the salmon',
      'Process mustard, vinegar and olive oil into a dessing',
      'Prepare the salad',
      'Add salmon cubes and dressing'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm6',
    categories: [
      'c6',
      'c3',
    ],
    title: 'Delicious Orange Mousse',
    affordability: Affordability.Affordable,
    complexity: Complexity.Hard,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121798851-4c036500-cc46-11eb-908d-07887fc3b203.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121797820-4dca2a00-cc40-11eb-977a-6565603d83cc.png',
    duration: 240,
    ingredients: [
      '4 Sheets of Gelatine',
      '150ml Orange Juice',
      '80g Sugar',
      '300g Yoghurt',
      '200g Cream',
      'Orange Peel',
    ],
    steps: [
      'Dissolve gelatine in pot',
      'Add orange juice and sugar',
      'Take pot off the stove',
      'Add 2 tablespoons of yoghurt',
      'Stir gelatin under remaining yoghurt',
      'Cool everything down in the refrigerator',
      'Whip the cream and lift it under die orange mass',
      'Cool down again for at least 4 hours',
      'Serve with orange peel',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm7',
    categories: [
      'c7',
    ],
    title: 'Pancakes',
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121798852-4c9bfb80-cc46-11eb-927c-16d7e8241f69.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121797821-4e62c080-cc40-11eb-93c2-42c6b7dba41c.png',
    duration: 20,
    ingredients: [
      '1 1/2 Cups all-purpose Flour',
      '3 1/2 Teaspoons Baking Powder',
      '1 Teaspoon Salt',
      '1 Tablespoon White Sugar',
      '1 1/4 cups Milk',
      '1 Egg',
      '3 Tablespoons Butter, melted',
    ],
    steps: [
      'In a large bowl, sift together the flour, baking powder, salt and sugar.',
      'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.',
      'Heat a lightly oiled griddle or frying pan over medium high heat.',
      'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm8',
    categories: [
      'c8',
    ],
    title: 'Creamy Indian Chicken Curry',
    affordability: Affordability.Pricey,
    complexity: Complexity.Challenging,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121798847-4a39a180-cc46-11eb-9792-032b1793f407.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121797815-4c98fd00-cc40-11eb-994f-45caa8ec5913.png',
    duration: 35,
    ingredients: [
      '4 Chicken Breasts',
      '1 Onion',
      '2 Cloves of Garlic',
      '1 Piece of Ginger',
      '4 Tablespoons Almonds',
      '1 Teaspoon Cayenne Pepper',
      '500ml Coconut Milk',
    ],
    steps: [
      'Slice and fry the chicken breast',
      'Process onion, garlic and ginger into paste and sauté everything',
      'Add spices and stir fry',
      'Add chicken breast + 250ml of water and cook everything for 10 minutes',
      'Add coconut milk',
      'Serve with rice'
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm9',
    categories: [
      'c9',
    ],
    title: 'Chocolate Souffle',
    affordability: Affordability.Affordable,
    complexity: Complexity.Hard,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121797817-4d319380-cc40-11eb-9b66-8727f710f2ea.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/121797817-4d319380-cc40-11eb-9b66-8727f710f2ea.png',
    duration: 45,
    ingredients: [
      '1 Teaspoon melted Butter',
      '2 Tablespoons white Sugar',
      '2 Ounces 70% dark Chocolate, broken into pieces',
      '1 Tablespoon Butter',
      '1 Tablespoon all-purpose Flour',
      '4 1/3 tablespoons cold Milk',
      '1 Pinch Salt',
      '1 Pinch Cayenne Pepper',
      '1 Large Egg Yolk',
      '2 Large Egg Whites',
      '1 Pinch Cream of Tartar',
      '1 Tablespoon white Sugar',
    ],
    steps: [
      'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.',
      'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.',
      'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.',
      'Place chocolate pieces in a metal mixing bowl.',
      'Place bowl over a pan of about 3 cups hot water over low heat.',
      'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.',
      'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.',
      'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.',
      'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.',
      'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.',
      'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.',
      'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.',
      'Transfer a little less than half of egg whites to chocolate.',
      'Mix until egg whites are thoroughly incorporated into the chocolate.',
      'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.',
      'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.',
      'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm10',
    categories: [
      'c2',
      'c5',
      'c3',
    ],
    title: 'Asparagus Salad with Cherry Tomatoes',
    affordability: Affordability.Luxurious,
    complexity: Complexity.Simple,
    imageURL:
        'https://user-images.githubusercontent.com/47301282/121798432-f1690980-cc43-11eb-9703-c4c64a38dfcb.png',
    mainPageImageURL:
        'https://user-images.githubusercontent.com/47301282/122035825-7e50c600-cdf0-11eb-87fe-a25f759c6df8.png',
    duration: 30,
    ingredients: [
      'White and Green Asparagus',
      '30g Pine Nuts',
      '300g Cherry Tomatoes',
      'Salad',
      'Salt, Pepper and Olive Oil'
    ],
    steps: [
      'Wash, peel and cut the asparagus',
      'Cook in salted water',
      'Salt and pepper the asparagus',
      'Roast the pine nuts',
      'Halve the tomatoes',
      'Mix with asparagus, salad and dressing',
      'Serve with Baguette'
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
];
