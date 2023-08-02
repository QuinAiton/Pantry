
class Recipe {
  // final int id;
  final String title;
  final String image;
  final List<dynamic> ingredients;
  final List<dynamic> healthLabels;
  // final List<dynamic> nutrients;
  final double servings;
  final double calories;
  final double totalTime;
  final List<dynamic> cuisineType;
  final Map<String, dynamic> images;
  const Recipe(
      {required this.title,
      required this.image,
      required this.ingredients,
      required this.healthLabels,
      // required this.nutrients,
      required this.servings,
      required this.calories,
      required this.totalTime,
      required this.cuisineType,
      required this.images
      
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      // id: json['recipe']['id'],
      title: json['recipe']['label'],
      image: json['recipe']['image'],
      ingredients: json['recipe']['ingredients'],
      healthLabels: json['recipe']['healthLabels'],
      // nutrients: json['recipe']['nutrients'],
      servings: json['recipe']['yield'],
      calories: json['recipe']['calories'],
      totalTime: json['recipe']['totalTime'],
      cuisineType: json['recipe']['cuisineType'],
      images: json['recipe']['images'],
      
    );
  }
}
