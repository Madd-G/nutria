import 'package:flutter/material.dart';
import 'package:nutria/models/models.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    super.key,
    required this.size,
    required this.object,
  });

  final Size size;
  final Data object;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  object.name!,
                  style: const TextStyle(
                      fontSize: 35.0, fontWeight: FontWeight.w900),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 25.0),
                    child: Text(
                      object.category!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            const Text(
              'Nutrition and mineral',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            Text(
              object.nutrients!,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 17.0),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            const Text(
              'Description',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              object.description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 17.0,
                overflow: TextOverflow.clip,
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            const Text(
              'Benefits',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            Text(
              object.benefits!,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 17.0),
            ),
          ],
        ),
      ),
    );
  }
}
