import 'package:flutter/material.dart';
import 'requests/fetchRecipes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'widgets/FeaturedItem.dart';
import 'widgets/ImageTextButton.dart';
import 'widgets/RecipeRowList.dart';
import 'requests/fetchRecipeOfTheDay.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var creamColor = const Color.fromARGB(248, 245, 239, 227);
    return MaterialApp(
      title: 'Pantry App',
      theme: ThemeData(
        scaffoldBackgroundColor: creamColor,
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: const MyHomePage(title: 'Pantry'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  late Future<List<dynamic>> futureRecipe;
  late Future<dynamic> futureRecipeOfTheDay;
  @override
  void initState() {
    super.initState();
    futureRecipe = fetchRecipes();
    futureRecipeOfTheDay = fetchRecipeOfTheDay();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      children: [
        const DrawerHeader(
          child: Text(
            'Pantry',
            style: TextStyle(color: Colors.green, fontSize: 30),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          selected: _selectedIndex == 0,
          onTap: () {
            _onItemTapped(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Recipes'),
          selected: _selectedIndex == 1,
          onTap: () {
            _onItemTapped(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Pantry'),
          selected: _selectedIndex == 2,
          onTap: () {
            _onItemTapped(2);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Groceries'),
          selected: _selectedIndex == 3,
          onTap: () {
            _onItemTapped(3);
            Navigator.pop(context);
          },
        )
      ],
    );
    var bottomNavigationBarView = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.kitchen),
          label: 'Pantry',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Groceries',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red[500],
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
    var creamColor = const Color.fromARGB(248, 245, 239, 227);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: creamColor,
      ),
      drawer: Drawer(
        backgroundColor: creamColor,
        child: listView,
      ),
      body: ListView(
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
      ),
      bottomNavigationBar: bottomNavigationBarView,
    );
  }
}
