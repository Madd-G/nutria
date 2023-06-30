import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              height: 150.0,
              width: 200.0,
              child: CachedNetworkImage(
                imageUrl: doc['item-image'],
                progressIndicatorBuilder: (_, url, download) {
                  if (download.progress != null) {
                    final percent = download.progress! * 100;
                    return Center(
                        child: Text(
                      'loading: ${percent.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey),
                    ));
                  }
                  return const Text('');
                },
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            '${doc['name']}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
