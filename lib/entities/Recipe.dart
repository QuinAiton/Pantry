class Recipe {
  final int id;
  final String title;
  final String image;

  const Recipe({required this.id, required this.title, required this.image});

  getId() => id;
  getTitle() => title;
  getImage() => image;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}
