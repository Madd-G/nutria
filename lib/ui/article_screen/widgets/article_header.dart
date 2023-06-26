import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
              imageUrl: doc['profile-image'],
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
              style: const TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          ],
        ),
      ],
    );
  }
}
