import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticleHeader extends StatelessWidget {
  const ArticleHeader({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: Image.network(
              doc['profile-image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${doc['author']}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              '${doc['date']}',
              style: const TextStyle(
                  color: Colors.grey, fontSize: 12.0),
            ),
          ],
        ),
      ],
    );
  }
}
