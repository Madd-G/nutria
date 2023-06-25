import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  const Article({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Text(
      doc['article'],
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );
  }
}
