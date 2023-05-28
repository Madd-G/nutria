import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Category',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryBox(
              imagePath: 'assets/images/fruit.png',
              route: '/fruit_list_screen',
              label: 'Fruit',
              onTap: () {
                context.read<ScreenBloc>().add(
                      ScreenEventGoToListScreen(),
                    );
              },
            ),
            const SizedBox(
              width: 10.0,
            ),
            CategoryBox(
              imagePath: 'assets/images/vegetable.png',
              route: '/vegetable_list_screen',
              label: 'Vegetable',
              onTap: () {
                context.read<ScreenBloc>().add(
                      ScreenEventGoToListScreen(),
                    );
              },
            )
          ],
        ),
      ],
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String imagePath;
  final String route;
  final String label;
  final VoidCallback onTap;

  const CategoryBox(
      {super.key,
      required this.imagePath,
      required this.route,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
