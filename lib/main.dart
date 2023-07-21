import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

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
  const MyHomePage({required this.title});
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
      body: ListView(
        children: [
          Container(
            color: creamColor,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                const OneColumnWidget(
                  title: 'Pantry',
                  image: 'assets/images/pantry.png',
                ),
                const TwoColumnWidget(items: [
                  {
                    'title': 'Recipes',
                    'image': 'assets/images/recipes.png',
                  },
                  {
                    'title': 'Recipes',
                    'image': 'assets/images/recipes.png',
                  }
                ]),
                const OneColumnWidget(
                  title: 'Groceries',
                  image: 'assets/images/groceries.png',
                ),
                const TwoColumnWidget(items: [
                  {
                    'title': 'Recipes',
                    'image': 'assets/images/recipes.png',
                  },
                  {
                    'title': 'Recipes',
                    'image': 'assets/images/recipes.png',
                  }
                ]),
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

class OneColumnWidget extends StatelessWidget {
  final String title;
  final String image;

  const OneColumnWidget({
    required this.image,
    required this.title,
    Key? key,
  }) : super(key: key);

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
        ),
      ),
    );
  }
}

class TwoColumnWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const TwoColumnWidget({
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
      children: items.map((item) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          height: 150,
          width: 180,
          child: Center(
            child: Column(
              children: [
                Text(item['title']),
                Image(image: AssetImage(item['image'])),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}


