import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'article_list_card.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key, required this.size, required this.docs});

  final Size size;
  final List<DocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, top: 8.0, right: 2.0),
      child: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot doc = docs[index];
          return ArticleListCard(size: size, doc: doc);
        },
      ),
    );
  }
}
