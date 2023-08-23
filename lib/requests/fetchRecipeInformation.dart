import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pantry/entities/Recipe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Recipe> fetchRecipeInformation(recipeId) async {
  var spoontacularKey = dotenv.env['spoontacular_key']!;
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$spoontacularKey'));

  if (response.statusCode == 200) {
    var decodedResponse = jsonDecode(response.body);
    var recipe = decodedResponse;
    var recipeItem = Recipe.fromJson(recipe);
    return recipeItem;
  } else {
    throw Exception('Failed to load dynamic');
  }
}
