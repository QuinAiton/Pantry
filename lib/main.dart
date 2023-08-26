import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pantry/requests/fetchRecipes.dart';
import 'package:pantry/requests/fetchRecipeOfTheDay.dart';
import 'package:pantry/pages/Pantry.dart';
import 'package:pantry/pages/Groceries.dart';
import 'package:pantry/pages/Recipes.dart';
import 'package:pantry/pages/Home.dart';

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
      home: const App(title: 'Pantry'),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key, required this.title});
  final String title;
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
      print(_pages[index]);
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [const Home(), const Recipes(), const Pantry(), const Groceries()];

  @override
  Widget build(BuildContext context) {
    var navDrawerItems = ListView(
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
        child: navDrawerItems,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: bottomNavigationBarView,
    );
  }
}
