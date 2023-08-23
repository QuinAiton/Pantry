class Recipe {
  final int id;
  final String title;
  final String image;
  final List<dynamic> ingredients;
  final List<dynamic> instructions;
  final int servings;
  final int totalTime;
  final List<dynamic> cuisineType;
  final bool vegetarian;
  final bool vegan;
  final bool cheap;
  final bool popular;
  final int healthScore;

  const Recipe(
      {required this.id,
      required this.title,
      required this.image,
      required this.ingredients,
      required this.instructions,
      required this.servings,
      required this.totalTime,
      required this.cuisineType,
      required this.vegetarian,
      required this.vegan,
      required this.cheap,
      required this.popular,
      required this.healthScore});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'] ?? '',
      ingredients: json['extendedIngredients']?.isNotEmpty == true
          ? json['extendedIngredients']
          : [],
      instructions: json['analyzedInstructions']?.isNotEmpty == true
          ? json['analyzedInstructions'][0]['steps']
          : [],
      servings: json['servings'],
      totalTime: json['readyInMinutes'],
      cuisineType: json['cuisines'] ?? [],
      vegetarian: json['vegetarian'] ?? false,
      vegan: json['vegan'] ?? false,
      cheap: json['cheap'] ?? false,
      popular: json['popular'] ?? false,
      healthScore: json['healthScore'] ?? 0,
    );
  }
}
