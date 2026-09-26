enum DietaryType { glutenFree, lactoseFree, vegetarian, vegan }

enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

class Meal {
  const Meal({
    required this.id,
    required this.title,
    required this.assetPath,

    required this.categories,
    this.dietaryTypes = const [],

    required this.duration,
    required this.complexity,
    required this.affordability,

    required this.ingredients,
    required this.steps,
  });

  final String id;

  final String title;
  final String assetPath;

  final List<String> categories;
  final List<DietaryType> dietaryTypes;

  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final List<String> ingredients;
  final List<String> steps;
}
