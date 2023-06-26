import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../detail_screen/screen/detail_screen.dart';

class ProductCard extends StatelessWidget {
  final DocumentSnapshot doc;

  const ProductCard({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
          const EdgeInsets.only(left: 6.0, right: 6.0, top: 1.0, bottom: 2.0),
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailScreen(doc: doc))),
        child: SizedBox(
          height: size.width * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.width * 0.35,
                child: CachedNetworkImage(
                  imageUrl: doc['item-image'],
                  progressIndicatorBuilder: (_, url, download) {
                    if (download.progress != null) {
                      final percent = download.progress! * 100;
                      return Center(child: Text('loading: ${percent.toStringAsFixed(0)}%'));
                    }
                    return const Text('');
                  },
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Container(
                  height: size.width * 0.35,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3.0),
                        bottomRight: Radius.circular(3.0)),
                    color: Color(0xffF7F9FB),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 0.5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc['name'],
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Category',
                              style: TextStyle(
                                  color: Color(0xffA1A8B9), fontSize: 12.0),
                            ),
                            Text(
                              doc['category'],
                              style: const TextStyle(fontSize: 10.0),
                            ),
                          ],
                        ),
                        const SizedBox(),
                        const SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                  color: Color(0xffA1A8B9), fontSize: 12.0),
                            ),
                            Text(
                              doc['general-info'][0],
                              textAlign: TextAlign.justify,
                              maxLines: 4,
                              style: const TextStyle(
                                fontSize: 10.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // ),
    );
    // );
  }
}
