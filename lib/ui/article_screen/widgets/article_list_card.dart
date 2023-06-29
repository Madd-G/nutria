import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../screens.dart';

class ArticleListCard extends StatelessWidget {
  const ArticleListCard({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width * 0.35,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(doc: doc),
            ),
          );
        },
        child: SizedBox(
          height: size.height * 0.35,
          child: Card(
            elevation: 0.0,
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
                        return Center(
                            child: Text(
                                'loading: ${percent.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey),));
                      }
                      return const Text('');
                    },
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Health',
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            SizedBox(
                              child: Text(
                                doc['title'],
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CachedNetworkImage(
                                      imageUrl: doc['profile-image'],
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
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '${doc["author"]} ● ${doc['date']}',
                                  style: const TextStyle(
                                      fontSize: 11.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
