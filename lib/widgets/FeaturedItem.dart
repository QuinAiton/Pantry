import 'package:flutter/material.dart';
import 'package:pantry/entities/Recipe.dart';
import 'package:pantry/utils/Navigate.dart';
import 'package:pantry/widgets/DetailsPage.dart';

class FeaturedItem extends StatelessWidget {
  final String title;


  final Recipe recipeData;

  FeaturedItem({
   
    required this.title,
    required this.recipeData,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Recipe Of The Day',
              style: TextStyle(fontSize: 20),
            )),
        TextButton(
          onPressed: () => navigator(
              context,
              DetailsPage(
                recipeData: recipeData,
              )),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 300,
              width: 400,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(recipeData.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200,
                  width: 400,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      recipeData.title,
                    ))
              ])),
        )
      ],
    );
  }
}
