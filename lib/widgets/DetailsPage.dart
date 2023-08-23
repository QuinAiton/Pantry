// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:pantry/requests/fetchSimilarRecipes.dart';
import 'package:pantry/widgets/RecipeRowList.dart';

class DetailsPage extends StatefulWidget {
  final dynamic recipeData;
  const DetailsPage({super.key, required this.recipeData});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<List<dynamic>> futureSimilarRecipes;
  @override
  void initState() {
    super.initState();
    futureSimilarRecipes = fetchSimilarRecipes(widget.recipeData.id);
  }
  @override
  Widget build(BuildContext context) {
    var creamColor = const Color.fromARGB(248, 245, 239, 227);
    var ingredients = widget.recipeData?.ingredients ?? [];
    var instructions = widget.recipeData?.instructions ?? [];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipeData?.title ?? ''),
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
                    image: NetworkImage(widget.recipeData?.image ?? ''),
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
                      Text(widget.recipeData?.servings.toString() ?? 'N/A'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Diet'),
                      Text(widget.recipeData?.cuisineType?.isNotEmpty == true
                          ? widget.recipeData!.cuisineType![0].toString()
                          : 'N/A')
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Prep Time'),
                      Text(widget.recipeData?.totalTime.toString() ?? 'N/A'),
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
                  )),
              FutureBuilder<List<dynamic>>(
                future: futureSimilarRecipes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return RecipeRowList(
                      title: 'Similar Recipes',
                      recipes: snapshot.data!,
                    );
                  } else {
                    return const Text('No recipes found.');
                  }
                },
              ),
            ]),
          )
        ]));
  }
}
