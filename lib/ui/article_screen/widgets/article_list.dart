import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key, required this.docs});

  final List<DocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      child: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot doc = docs[index];
          return ArticleListCard(doc: doc);
        },
      ),
    );
  }
}
