import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/ui/article_screen/widgets/article_list_card.dart';

import '../../detail_screen/screen/detail_screen.dart';

class ArticleRecommendation extends StatelessWidget {
  const ArticleRecommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rekomendasi artikel hari ini',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('article').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const SizedBox(
                child: Center(child: Text("Not found")),
              );
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                reverse: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  var doc = documents[index];
                  return GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(doc: doc),
                            ),
                          ),
                      child: ArticleListCard(
                        doc: doc,
                      ));
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
