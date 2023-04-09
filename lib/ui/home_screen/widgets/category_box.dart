import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  final String imagePath;
  final String route;
  final String label;

  const CategoryBox(
      {super.key,
      required this.imagePath,
      required this.route,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.white, offset: Offset(0.0, 2.0), blurRadius: 2.0)
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
            Text(
              label,
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
