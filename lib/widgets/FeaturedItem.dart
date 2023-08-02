import 'package:flutter/material.dart';

class FeaturedItem extends StatelessWidget {
  final String title;
  final String image;
  final String body;

  const FeaturedItem({
    required this.image,
    required this.body,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Recipe Of The Day',
              style: TextStyle(fontSize: 20),
            )),
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
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.blue,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
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
