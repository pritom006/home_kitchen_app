import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:home_kitchen/models/recipe.dart';

class RecipeApi {
  //   var options = {
//   method: 'GET',
//   url: 'https://yummly2.p.rapidapi.com/feeds/list',
//   params: {limit: '18', start: '0', tag: 'list.recipe.popular'},
//   headers: {
//     'x-rapidapi-host': 'yummly2.p.rapidapi.com',
//     'x-rapidapi-key': 'c6ba5d0362mshcab1c901c682b9cp192143jsnefef3bfc33cc'
//   }
// };

  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {'limit': '18', 'start': '0', 'tag': 'list.recipe.popular'});

    final response = await http.get(uri, headers: {
      'x-rapidapi-host': 'yummly2.p.rapidapi.com',
      'x-rapidapi-key': 'c6ba5d0362mshcab1c901c682b9cp192143jsnefef3bfc33cc',
      'useQueryString': 'true',
    });

    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipeFromSnaphot(_temp);
  }
}
