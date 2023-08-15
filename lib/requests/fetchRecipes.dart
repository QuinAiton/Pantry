import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pantry/entities/Recipe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<dynamic>> fetchRecipes() async {
  var spoontacularKey = dotenv.env['spoontacular_key']!;
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/random?apiKey=$spoontacularKey&number=10'));

  if (response.statusCode == 200) {
    var decodedResponse = jsonDecode(response.body);
    var recipes = decodedResponse['recipes'];
    var recipeList = recipes.map((recipe) => Recipe.fromJson(recipe)).toList();
    return recipeList;
  } else {
    throw Exception('Failed to load dynamic');
  }
}
