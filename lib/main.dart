import 'package:flutter/material.dart';
import 'requests/getRecipes.dart';
import 'entities/Recipe.dart';

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

  late Future<List<Recipe>?> futureRecipe;

  @override
  void initState() {
    super.initState();
    futureRecipe = fetchRecipes();
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
        // title: Text(
        //   widget.title,
        //   style: const TextStyle(color: Colors.black),
        // ),
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
                const TiledButton(
                    image: 'assets/tomatoes_whitedrop.jpg',
                    text: 'Unlock Premium and tailored recipes',
                    buttonText: 'Join For Free'),
                FutureBuilder<List<Recipe>?>(
                  future: futureRecipe,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While the data is still loading
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If there's an error, display the error message
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      // Wrap the ListView.builder with a Container to give it a size.
                      return SizedBox(
                        height:
                            300, // Replace this with the desired height of the list
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // Return a Text widget for each recipe title
                            return TwoColumnWidget(
                              items: snapshot.data!,
                              title: 'Recipes',
                            );
                          },
                        ),
                      );
                    } else {
                      // If there's no data and no error, show a message that there are no recipes.
                      return const Text('No recipes found.');
                    }
                  },
                ),
                const OneColumnWidget(
                  title: 'Recipe Of The Day',
                  body: 'Place holder text',
                  image: 'assets/tomatoes_whitedrop.jpg',
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

class TiledButton extends StatelessWidget {
  final String text;
  final String image;
  final String buttonText;

  const TiledButton({
    required this.image,
    required this.buttonText,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(
              image), // Use AssetImage to create an ImageProvider from the asset
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.srgbToLinearGamma(),
        ),
      ),

      height: 150,
      width: 400,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red[400]),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ))
      ]),
    );
  }
}

class OneColumnWidget extends StatelessWidget {
  final String title;
  final String image;
  final String body;

  const OneColumnWidget({
    required this.image,
    required this.body,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: 300,
            width: 400,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.srgbToLinearGamma()),
                ),
                height: 200,
                width: 400,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    body,
                  ))
            ])),
      ],
    );
  }
}

class TwoColumnWidget extends StatelessWidget {
  final String title;
  final List<Recipe> items;

  const TwoColumnWidget({
    required this.items,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((recipe) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(recipe.image),
                  fit: BoxFit.cover,
                ),
              ),
              height: 150,
              width: 180,
              child: Center(
                child: Column(
                  children: [
                    Text(recipe.title),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
