import 'package:flutter/material.dart';
import 'RecipeItems.dart';

class RecipeRowList extends StatelessWidget {
  final List<dynamic> recipes;
  final String title;
  const RecipeRowList({Key? key, required this.recipes, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 255,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1, // Set itemCount to 1 for the entire list of recipes
              itemBuilder: (context, index) {
                return RecipeItems(
                  items: recipes, // Pass the entire recipes list
                  title: 'Recipes',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
