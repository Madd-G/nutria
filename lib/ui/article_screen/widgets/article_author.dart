import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/responsive.dart';

import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';

class ArticleAuthor extends StatelessWidget {
  const ArticleAuthor({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: SizedBox(
            width: (Responsive.isTablet(context)) ? 48.0 : 35.0,
            height: (Responsive.isTablet(context)) ? 48.0 : 35.0,
            child: CachedNetworkImage(
              imageUrl: doc[l10n.lang]['profile-image'],
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
        ),
        SizedBox(
          width: (Responsive.isTablet(context)) ? 15.0 : 10.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${doc[l10n.lang]['author']}',
              style: TextStyle(
                  // color: Colors.black,
                  fontSize: (Responsive.isTablet(context)) ? 20.0 : 13.0,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              '${doc[l10n.lang]['date']}',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: (Responsive.isTablet(context)) ? 18.0 : 11.0),
            ),
          ],
        ),
      ],
    );
  }
}
