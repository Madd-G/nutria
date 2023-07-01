import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({
    super.key,
    required this.size,
    required this.doc,
  });

  final Size size;
  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.32,
          width: size.width,
          child: CachedNetworkImage(
            imageUrl: doc['item-image'],
            // progressIndicatorBuilder: (_, url, download) {
            //   if (download.progress != null) {
            //     final percent = download.progress! * 100;
            //     return Center(
            //         child: Text(
            //       'loading: ${percent.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey),
            //     ));
            //   }
            //   return const Text('');
            // },
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            '${doc['picture-description']}',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
