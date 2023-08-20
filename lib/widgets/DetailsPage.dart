// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final dynamic recipeData;
  const DetailsPage({super.key, required this.recipeData});

  

  @override
  Widget build(BuildContext context) {
    var creamColor = const Color.fromARGB(248, 245, 239, 227);
    var ingredients = recipeData?.ingredients ?? [];
    var instructions = recipeData?.instructions ?? [];

    return Scaffold(
        appBar: AppBar(
          title: Text(recipeData?.title ?? ''),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(recipeData?.image ?? ''),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ),
              ),

              const SizedBox(height: 20), // Add initial gap

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('portions '),
                      Text(recipeData?.servings.toString() ?? 'N/A'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Diet'),
                      Text(recipeData?.cuisineType?.isNotEmpty == true
                          ? recipeData!.cuisineType![0].toString()
                          : 'N/A')
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Prep Time'),
                      Text(recipeData?.totalTime.toString() ?? 'N/A'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add initial gap

              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                      Container(
                    width: 400,
                        color: Colors.grey[300],
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Ingredients',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                                for (int index = 0;
                                    index < ingredients.length - 1;
                                    index++)
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ingredients[index]['nameClean'],
                                          ),
                                          Text(
                                              '${ingredients[index]['amount']} ' +
                                                  ingredients[index]['unit'])
                                        ],
                                  )),
                          ],
                        )),
                  )
                ],
                  ))),
              const SizedBox(height: 20), // Add initial gap
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SingleChildScrollView(
                    child:
              Column(
                children: [
                        Container(
                    width: 400,
                          color: Colors.green[200],
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Instructions',
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Column(
                                  children: List<Widget>.generate(
                                      instructions.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '${index + 1}. ' +
                                                  instructions[index]['step'],
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]),
          )
        ]));
  }
}
