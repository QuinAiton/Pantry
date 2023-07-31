class Recipe {
  // final int id;
  final String title;
  final String image;

  const Recipe({required this.title, required this.image});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      // id: json['recipe']['id'],
      title: json['recipe']['label'],
      image: json['recipe']['image'],
    );
  }
}
