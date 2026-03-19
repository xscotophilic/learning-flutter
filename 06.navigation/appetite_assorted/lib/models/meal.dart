enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

enum DietaryType { glutenFree, lactoseFree, vegetarian, vegan }

class Meal {
  const Meal({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.mainPageImageURL,
    required this.categories,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.ingredients,
    required this.steps,
    this.dietaryTypes = const [],
  });

  final String id;

  final String title;
  final String imageURL;
  final String mainPageImageURL;

  final List<String> categories;

  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final List<String> ingredients;
  final List<String> steps;

  final List<DietaryType> dietaryTypes;
}
