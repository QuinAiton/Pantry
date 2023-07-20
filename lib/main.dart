import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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
    var creamColor = const Color.fromARGB(248, 245, 239, 227);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
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
      body: Container(
        color: creamColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
            children: [
          const OneColumnWidget(
              title: 'Pantry', image: 'assets/images/pantry.png'),
          TwoColumnWidget(items: [
            {
              title: 'Recipies',
              image: 'assets/images/recipes.png',
            }
          ]),
          const OneColumnWidget(
            title: 'Groceries',
            image: 'assets/images/groceries.png',
          ),
          TwoColumnWidget(items: [
            {
              title: 'Recipies',
              image: 'assets/images/recipes.png',
            }
          ]),
        ]
                .map((widget) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: widget,
                    ))
                .toList()),
      ),
      bottomNavigationBar: bottomNavigationBarView,
    );
  }
}

class OneColumnWidget extends StatelessWidget {
  final String title;
  final String image;

  const OneColumnWidget({
    required this.image,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
      ),
      height: 200,
      child: Center(
          child: Column(
        children: [
          Image(
            image: AssetImage(image),
          ),
          Text(title),
        ],
      )),
    );
  }
}

class TwoColumnWidget extends StatelessWidget {
  final List<String, dynamic> items;
  const TwoColumnWidget({
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: ((context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    height: 150,
                    width: 180,
                    child: Center(
                      child: Text(items[index]['title']),
                    )),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    height: 150,
                    width: 180,
                    child: Center(
                      child: Image(
                        image: AssetImage(items[index]['image']),
                      ),
                    )),
              ],
            )),
        itemCount: 4);
  }
}

      // body: ListView.builder(
      //     itemBuilder: ((context, index) => Container(
      //           padding: const EdgeInsets.symmetric(vertical: 10),
      //           child: Container(
      //             height: 400,
      //             color: Colors.white,
      //             child: Center(child: Text('Item $index')),
      //           ),
      //         )),