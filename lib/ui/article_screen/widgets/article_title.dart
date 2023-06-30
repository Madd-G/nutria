import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticleTitle extends StatelessWidget {
  const ArticleTitle({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Text(
      doc['title'],
      style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.w700),
    );
  }
}
