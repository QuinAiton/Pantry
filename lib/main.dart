import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var creamColor = Color.fromARGB(248, 245, 239, 227);
    return MaterialApp(
      title: 'Pantry App',
      theme: ThemeData(
        scaffoldBackgroundColor: creamColor,
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black, //<-- SEE HERE
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
        )),
        ListTile(
            title: const Text('Home'),
            selected: _selectedIndex == 0,
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
            }),
        ListTile(
            title: const Text('Recipies'),
            selected: _selectedIndex == 1,
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
            }),
        ListTile(
            title: const Text('Pantry'),
            selected: _selectedIndex == 2,
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
            }),
        ListTile(
            title: const Text('Groceries'),
            selected: _selectedIndex == 3,
            onTap: () {
              _onItemTapped(3);
              Navigator.pop(context);
            })
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
    var creamColor = Color.fromARGB(248, 245, 239, 227);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: creamColor,
      ),
      drawer: Drawer(
        backgroundColor: creamColor,
        child: listView,
      ),
      
      body: const Center(
      ),
      bottomNavigationBar: bottomNavigationBarView,
    );
  }
}


