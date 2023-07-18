import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantry App',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xF8F7F6F4),
          primarySwatch: Colors.green
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
        DrawerHeader(
            child: Text(
          'Pantry',
        )),
        ListTile(
            title: const Text('Home'),
            selected: _selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              _onItemTapped(0);
              // Then close the drawer
              Navigator.pop(context);
            }),
        ListTile(
            title: const Text('Recipies'),
            selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              _onItemTapped(1);
              // Then close the drawer
              Navigator.pop(context);
            }),
        ListTile(
            title: const Text('Pantry'),
            selected: _selectedIndex == 2,
            onTap: () {
              // Update the state of the app
              _onItemTapped(2);
              // Then close the drawer
              Navigator.pop(context);
            }),
        ListTile(
            title: const Text('Groceries'),
            selected: _selectedIndex == 3,
            onTap: () {
              // Update the state of the app
              _onItemTapped(3);
              // Then close the drawer
              Navigator.pop(context);
            })
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: listView,
      ),
      body: const Center(
      ),
    );
  }
}


