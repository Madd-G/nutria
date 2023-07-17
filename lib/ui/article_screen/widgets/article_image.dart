import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: size.height * 0.32,
              width: size.width,
              child: CachedNetworkImage(
                imageUrl: doc['en'.tr]['item-image'],
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
              height: 10.0,
            ),
          ],
        ),
        Positioned(
          top: 50,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                // border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  // color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
