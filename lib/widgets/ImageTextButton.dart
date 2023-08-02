import 'package:flutter/material.dart';

class ImageTextButton extends StatelessWidget {
  final String text;
  final String image;
  final String buttonText;

  const ImageTextButton({
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
