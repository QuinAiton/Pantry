import 'package:flutter/material.dart';
import 'package:pantry/entities/Recipe.dart';

class DetailsPage extends StatelessWidget {
  final Recipe recipeData;

  const DetailsPage({super.key, required this.recipeData});

  @override
  Widget build(BuildContext context) {
    var creamColor = const Color.fromARGB(248, 245, 239, 227);
    return Scaffold(
        appBar: AppBar(
          title: Text(recipeData.title),
          backgroundColor: creamColor,
          elevation: 0,
        ),
        body: ListView(children: [
          Container(
            color: creamColor,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: NetworkImage(recipeData.image),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('portions '),
                      Text(recipeData.servings.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Diet'),
                      Text(recipeData.cuisineType.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Prep Time'),
                      Text(recipeData.totalTime.toString()),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 300,
                    width: 400,
                    color: Colors.grey[350],
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('Ingredients'),
                            for (int index = 0; index < 3; index++)
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [Text('data'), Text('data')],
                                  )),
                          ],
                        )),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 300,
                    width: 400,
                    color: Colors.green,
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('Instructions'),
                            for (int index = 0; index < 3; index++)
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [Text('data'), Text('data')],
                                  )),
                          ],
                        )),
                  )
                ],
              ),
            ]),
          )
        ]));
  }
}
