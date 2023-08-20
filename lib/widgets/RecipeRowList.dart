import 'package:flutter/material.dart';
import 'RecipeItems.dart';

class RecipeRowList extends StatelessWidget {
  final List<dynamic> recipes;
  const RecipeRowList({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'New Recipes',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Flexible(
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
