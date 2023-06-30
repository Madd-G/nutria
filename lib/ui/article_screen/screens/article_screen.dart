import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/widgets/nutriai_button.dart';
import '../widgets/widgets.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key, required this.doc}) : super(key: key);

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NutriAIButton(
      mainWidget: Scaffold(
        body: Stack(
          children: [
            ArticleImage(size: size, doc: doc),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SizedBox(
                  height: size.height * 0.76,
                  width: size.width,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          ArticleTitle(doc: doc),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ArticleHeader(doc: doc),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Article(doc: doc)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
