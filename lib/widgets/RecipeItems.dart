import 'package:flutter/material.dart';

class RecipeItems extends StatelessWidget {
  final String title;
  final List<dynamic> items;

  const RecipeItems({
    required this.items,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((recipe) {
        return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(recipe.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 125,
                  width: 180,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                      width: 1 / 3 * MediaQuery.of(context).size.width,
                      child: Text(
                        recipe.title,
                        textAlign: TextAlign.start,
                      )),
                )
              ],
            ));
      }).toList(),
    );
  }
}
