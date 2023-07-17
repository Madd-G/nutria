import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../responsive.dart';
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
      height: (Responsive.isTablet(context))
          ? size.width * 0.24
          : size.width * 0.35,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(doc: doc),
            ),
          );
        },
        child: Card(
          elevation: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: size.width * 0.35,
                child: CachedNetworkImage(
                  imageUrl: doc['en'.tr]['item-image'],
                  // progressIndicatorBuilder: (_, url, download) {
                  //   if (download.progress != null) {
                  //     final percent = download.progress! * 100;
                  //     return Center(
                  //         child: Text(
                  //       'loading: ${percent.toStringAsFixed(0)}%',
                  //       style: const TextStyle(color: Colors.grey),
                  //     ));
                  //   }
                  //   return const Text('');
                  // },
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
                          Text(
                            'Health'.tr,
                            style: TextStyle(
                                fontSize:
                                    (Responsive.isTablet(context)) ? 18 : 10,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: (Responsive.isTablet(context)) ? 5 : 0,
                          ),
                          SizedBox(
                            child: Text(
                              doc['en'.tr]['title'],
                              maxLines: 3,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: (Responsive.isTablet(context))
                                      ? 25
                                      : 15.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: (Responsive.isTablet(context)) ? 10 : 10.0,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: SizedBox(
                                  width: (Responsive.isTablet(context))
                                      ? 23.0
                                      : 23.0,
                                  height: (Responsive.isTablet(context))
                                      ? 23.0
                                      : 23.0,
                                  child: CachedNetworkImage(
                                    imageUrl: doc['en'.tr]['profile-image'],
                                    // progressIndicatorBuilder:
                                    //     (_, url, download) {
                                    //   if (download.progress != null) {
                                    //     final percent =
                                    //         download.progress! * 100;
                                    //     return Center(
                                    //         child: Text(
                                    //       'loading: ${percent.toStringAsFixed(0)}%',
                                    //       style: const TextStyle(
                                    //           color: Colors.grey),
                                    //     ));
                                    //   }
                                    //   return const Text('');
                                    // },
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.isTablet(context)? 10.0 : 8.0,
                              ),
                              Text(
                                '${doc['en'.tr]["author"]} • ${doc['en'.tr]['date']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: (Responsive.isTablet(context))
                                      ? 18
                                      : 11.0,
                                  // color: Colors.grey,
                                ),
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
    );
  }
}
