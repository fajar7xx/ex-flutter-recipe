import 'dart:convert';
import 'recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi{
  static Future<List<Recipe>> getRecipe() async{
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      "limit": "18",
      "start": "0",
      "tag": "list.recipe.popular"
    });

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "ab22901b0dmshaa58baa1e7987d0p15fea6jsn4f94881150f4",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "userQueryString": "true"

    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for(var i in data['feed']){
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}