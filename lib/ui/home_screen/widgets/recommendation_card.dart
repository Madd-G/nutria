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
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
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
                      'loading: ${percent.toStringAsFixed(0)}%',
                    ));
                  }
                  return const Text('');
                },
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 5.0,
            bottom: 15.0,
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                child: Text(
                  '${doc['name']}',
                  style: const TextStyle(
                    color: Colors.black26,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
