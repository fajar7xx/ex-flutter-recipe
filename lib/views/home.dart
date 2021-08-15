import 'package:flutter/material.dart';
import 'package:recipe_list_app/models/recipe.dart';
import 'package:recipe_list_app/models/recipe_api.dart';
import 'package:recipe_list_app/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Recipe> _recipes;
  // ignore: unused_field
  bool _isLoading = true;

  @override

  void initState(){
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async{
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
    print(_recipes);
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(
                width: 10,
              ),
              Text('Food Recipe')
            ],
          ),
        ),
        // body: RecipeCard(
        //     title: "My recipe",
        //     cookTime: "20 min",
        //     rating: "4.1",
        //     thumbnailUrl:
        //         "'https://lh3.googleusercontent.com/ei5eF1LRFkkcekhjdR_8XgOqgdjpomf-rda_vvh7jIauCgLlEWORINSKMRR6I6iTcxxZL9riJwFqKMvK0ixS0xwnRHGMY4I5Zw=s360',")
        body: _isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: _recipes.length,
          itemBuilder: (context, index){
            return RecipeCard(title: _recipes[index].name, cookTime: _recipes[index].totalTime, rating: _recipes[index].rating.toString(), thumbnailUrl: _recipes[index].images);
          },
        )
    );
  }
}
