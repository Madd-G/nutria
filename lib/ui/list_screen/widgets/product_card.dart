import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../../detail_screen/screen/detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.doc,
    required this.l10n,
  });

  final DocumentSnapshot doc;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            doc: doc,
                            l10n: l10n,
                          ))),
              child: Center(
                child: CachedNetworkImage(
                  // imageUrl: doc[l10n.lang]['item-image'],
                  imageUrl: doc[l10n.lang]['image-tr'],
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
            child: Text(
              doc[l10n.lang]['name'],
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 15.0 : 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
    // );
  }
}
