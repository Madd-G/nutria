import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/ui/home_screen/widgets/widgets.dart';

import '../../detail_screen/screen/detail_screen.dart';
import 'article_recommendation.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rekomendasi',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rekomendasi hari ini',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  '',
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
            stream: FirebaseFirestore.instance
                .collection('items')
                .orderBy('viewed', descending: true)
                .snapshots(),
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
                return SizedBox(
                  height: 180,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    reverse: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      var doc = documents[index];
                      return GestureDetector(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(doc: doc),
                                ),
                              ),
                          child: RecommendationCard(doc: doc));
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const ArticleRecommendation(),
        ],
      ),
    );
  }
}
