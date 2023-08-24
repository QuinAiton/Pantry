import 'package:flutter/material.dart';
import 'package:pantry/widgets/FeaturedItem.dart';
import 'package:pantry/widgets/ImageTextButton.dart';
import 'package:pantry/widgets/RecipeRowList.dart';
import 'package:pantry/requests/fetchRecipes.dart';
import 'package:pantry/requests/fetchRecipeOfTheDay.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<dynamic>> futureRecipe;
  late Future<dynamic> futureRecipeOfTheDay;
  var creamColor = const Color.fromARGB(248, 245, 239, 227);
  @override
  void initState() {
    super.initState();
    futureRecipe = fetchRecipes();
    futureRecipeOfTheDay = fetchRecipeOfTheDay();
  }

  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          color: creamColor,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              const ImageTextButton(
                  image: 'assets/tomatoes_whitedrop.jpg',
                  text: 'Unlock Premium and tailored recipes',
                  buttonText: 'Join For Free'),
              FutureBuilder<List<dynamic>>(
                future: futureRecipe,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return RecipeRowList(
                      title: 'New Recipes',
                      recipes: snapshot.data!,
                    );
                  } else {
                    return const Text('No recipes found.');
                  }
                },
              ),
              FutureBuilder<dynamic>(
                future: futureRecipeOfTheDay,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the data is still loading
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // If there's an error, display the error message
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    // Wrap the ListView.builder with a Cont
                    //ainer to give it a size.
                    // var random = Random().nextInt(snapshot.data!.length);
                    return FeaturedItem(
                      title: 'Recipe Of The Day',
                      recipeData: snapshot.data,
                    );
                  } else {
                    // If there's no data and no error, show a message that there are no recipes.
                    return const Text('No recipes found.');
                  }
                },
              ),
            ]
                .map((widget) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: widget,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
