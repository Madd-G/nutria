import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({
    super.key,
    required this.size,
    required this.doc,
  });

  final Size size;
  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: SizedBox(
            height: 250.0,
            width: size.width,
            child: Image.network(
              doc['item-image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            '${doc['picture-description']}',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
