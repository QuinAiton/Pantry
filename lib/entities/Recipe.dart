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
      image: json['image'],
      ingredients: json['extendedIngredients'],
instructions: json['analyzedInstructions'] != null &&
              json['analyzedInstructions'].isNotEmpty
          ? json['analyzedInstructions'][0]['steps']
          : null,
      servings: json['servings'],
      totalTime: json['readyInMinutes'],
      cuisineType: json['cuisines'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      cheap: json['cheap'],
      popular: json['glutenFree'],
      healthScore: json['healthScore'],
    );
  }
}
