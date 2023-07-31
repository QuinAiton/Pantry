import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pantry/entities/Recipe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Recipe>?> fetchRandomRecipes() async {
  var id = dotenv.env['edamam_app_id'];
  var key = dotenv.env['edamam_app_key'];
  var query =
      'app_id=$id&app_key=$key&dishType=Main%20course&random=true&type=public';
  var url = 'https://api.edamam.com/api/recipes/v2?';
  final response = await http.get(Uri.parse('$url$query'));
  if (response.statusCode == 200) {
    // If the server returned a 200 OK response, parse the JSON.
    var decodedResponse = jsonDecode(response.body);
    var results = decodedResponse['hits'] as List<dynamic>;
    var recipeList = results.map((recipe) => Recipe.fromJson(recipe)).toList();
    return recipeList;
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load recipes');
  }
}
