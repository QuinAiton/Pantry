import 'package:http/http.dart' as http;
import 'package:pantry/.env';
import 'dart:convert';
import 'package:pantry/entities/Recipe.dart';

Future<List<Recipe>?> fetchRecipes() async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?apiKey=$Spoontacular_key'));

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response, parse the JSON.
    var decodedResponse = jsonDecode(response.body);
    var results = decodedResponse['results'] as List<dynamic>;
    var recipeList = results.map((recipe) => Recipe.fromJson(recipe)).toList();
    return recipeList;
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load recipes');
  }
}

