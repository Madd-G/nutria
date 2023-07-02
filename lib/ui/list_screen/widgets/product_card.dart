import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../responsive.dart';
import '../../detail_screen/screen/detail_screen.dart';

class ProductCard extends StatelessWidget {
  final DocumentSnapshot doc;

  const ProductCard({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(doc: doc))),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: doc['item-image'],
                    // progressIndicatorBuilder: (_, url, download) {
                    //   if (download.progress != null) {
                    //     final percent = download.progress! * 100;
                    //     return Text('$percent% done loading');
                    //   }
                    //   return const Text('');
                    // },
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              doc['name'],
              style:
              TextStyle(fontSize: Responsive.isTablet(context) ? 20.0 : 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
    // );
  }
}
