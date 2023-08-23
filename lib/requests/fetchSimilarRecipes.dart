import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pantry/entities/Recipe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pantry/requests/fetchRecipeInformation.dart';

Future<List<dynamic>> fetchSimilarRecipes(recipeId) async {
  var spoontacularKey = dotenv.env['spoontacular_key']!;
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/$recipeId/similar?apiKey=$spoontacularKey&number=5'));

  if (response.statusCode == 200) {
    var decodedResponse = jsonDecode(response.body);
    var recipes = decodedResponse;
    var recipeInfo = await Future.wait<dynamic>(
      recipes
          .map<Future<dynamic>>(
              (recipe) => fetchRecipeInformation(recipe['id']))
          .toList(),
    );

    return recipeInfo;
  } else {
    throw Exception('Failed to load dynamic');
  }
}
