import 'package:flutter/material.dart';

class Pantry extends StatefulWidget {
  const Pantry({super.key});

  @override
  State<Pantry> createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  @override
  Widget build(BuildContext context) {
    var jsonItems = [
      {"name": "Beans", "category": "Canned Goods"},
      {"name": "Soups", "category": "Canned Goods"},
      {"name": "Vegetables", "category": "Canned Goods"},
      {"name": "Fruits", "category": "Canned Goods"},
      {"name": "Tuna", "category": "Canned Goods"},
      {"name": "Rice", "category": "Grains and Pasta"},
      {"name": "Pasta", "category": "Grains and Pasta"},
      {"name": "Quinoa", "category": "Grains and Pasta"},
      {"name": "Oats", "category": "Grains and Pasta"},
      {"name": "Flour", "category": "Grains and Pasta"},
      {"name": "Sugar", "category": "Baking Supplies"},
      {"name": "Salt", "category": "Baking Supplies"},
      {"name": "Baking powder", "category": "Baking Supplies"},
      {"name": "Baking soda", "category": "Baking Supplies"},
      {"name": "Vanilla extract", "category": "Baking Supplies"},
      {"name": "Ketchup", "category": "Condiments and Sauces"},
      {"name": "Mustard", "category": "Condiments and Sauces"},
      {"name": "Mayonnaise", "category": "Condiments and Sauces"},
      {"name": "Soy sauce", "category": "Condiments and Sauces"},
      {"name": "Hot sauce", "category": "Condiments and Sauces"},
      {"name": "Salt", "category": "Spices and Herbs"},
      {"name": "Pepper", "category": "Spices and Herbs"},
      {"name": "Cumin", "category": "Spices and Herbs"},
      {"name": "Paprika", "category": "Spices and Herbs"},
      {"name": "Basil", "category": "Spices and Herbs"},
      {"name": "Olive oil", "category": "Oils and Vinegars"},
      {"name": "Vegetable oil", "category": "Oils and Vinegars"},
      {"name": "Vinegar", "category": "Oils and Vinegars"},
      {"name": "Chips", "category": "Snacks"},
      {"name": "Crackers", "category": "Snacks"},
      {"name": "Popcorn", "category": "Snacks"},
      {"name": "Nuts", "category": "Snacks"},
      {"name": "Granola bars", "category": "Snacks"},
      {"name": "Cereal", "category": "Breakfast Foods"},
      {"name": "Oatmeal", "category": "Breakfast Foods"}
    ];
    var itemCategories =
        jsonItems.map((item) => item['category']).toSet().toList();

    var categorizedItems = itemCategories.map((category) {
      return {
        'category': category,
        'items':
            jsonItems.where((item) => item['category'] == category).toList()
      };
    }).toList();
    return Stack(
      children: [
        ListView.builder(
          itemCount: categorizedItems.length,
          itemBuilder: (context, index) {
            final item = categorizedItems[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.green,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      item['category'].toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ), // Display the category
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (item['items'] as List<dynamic>)
                      .asMap()
                      .entries
                      .map<Widget>((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return Container(
                      color: index % 2 == 1 ? Colors.green[50] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: double
                              .infinity, // Set the width to double.infinity
                          child: Text(
                            item['name'].toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            );
          },
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed logic here
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
