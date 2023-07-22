import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
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
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: (Responsive.isMobile(context))
          ? size.width * 0.35
          : size.width * 0.30,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(
                doc: doc,
                l10n: l10n,
              ),
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
                  imageUrl: doc[l10n.lang]['item-image'],
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
                            l10n.health,
                            style: TextStyle(
                                fontSize:
                                    (Responsive.isMobile(context)) ? 10 : 18,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: (Responsive.isMobile(context)) ? 0 : 5,
                          ),
                          SizedBox(
                            child: Text(
                              doc[l10n.lang]['title'],
                              maxLines: 3,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: (Responsive.isMobile(context))
                                      ? 15.0
                                      : 25.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: SizedBox(
                                  width: 23.0,
                                  height: 23.0,
                                  child: CachedNetworkImage(
                                    imageUrl: doc[l10n.lang]['profile-image'],
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
                                width:
                                    Responsive.isMobile(context) ? 8.0 : 10.0,
                              ),
                              Text(
                                '${doc[l10n.lang]["author"]} • ${doc[l10n.lang]['date']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: (Responsive.isMobile(context))
                                      ? 11.0
                                      : 18.0,
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
