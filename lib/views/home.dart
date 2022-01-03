import 'package:flutter/material.dart';
import 'package:home_kitchen/views/widgets/recipe_card.dart';
import 'package:home_kitchen/models/recipe_api.dart';
import 'package:home_kitchen/models/recipe.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.black, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ]),
          child: Row(
            children: [
              Expanded(
                  child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(12.0)),
                onPressed: () {},
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 27,
                ),
              )),
              Expanded(
                  child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(12.0)),
                onPressed: () {},
                child: const Icon(
                  Icons.account_circle,
                  size: 27,
                ),
              )),
              Expanded(
                  child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(12.0)),
                onPressed: () {},
                child: const Icon(
                  Icons.settings,
                  size: 27,
                ),
              )),
              Expanded(
                  child: TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(12.0)),
                onPressed: () {},
                child: const Icon(
                  Icons.home,
                  size: 27,
                ),
              )),
            ],
          ),
        ),
        drawer: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.purpleAccent,
              Colors.purpleAccent.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          )),
          child: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                    child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  backgroundImage: ExactAssetImage("images/my_profile.jpg"),
                )),
                ElevatedButton(onPressed: () {}, child: Text("Profile")),
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.only(top: 60.0),
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Resturent Menu",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Account Menu",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 55.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Home's Kitchen")
                  ],
                ),
              ),
            ),
            _recipes == null
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((contex, index) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }, childCount: 1))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (contex, index) {
                      return RecipeCard(
                          title: _recipes[index].name,
                          cookTime: _recipes[index].totalTime,
                          rating: _recipes[index].rating.toString(),
                          thumbnailUrl: _recipes[index].images);
                    },
                    childCount: _recipes.length,
                  )),
          ],
        ));
  }
}
