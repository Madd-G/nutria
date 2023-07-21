import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../responsive.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.doc,
    required this.l10n,
  });

  final DocumentSnapshot<Object?> doc;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Card(
              child: SizedBox(
                height: (Responsive.isTablet(context)) ? 165.0 : 140.0,
                width: (Responsive.isTablet(context)) ? 230.0 : 200.0,
                child: CachedNetworkImage(
                  // imageUrl: doc[l10n.lang]['item-image'],
                  imageUrl: doc[l10n.lang]['image-tr'],
                  progressIndicatorBuilder: (_, url, download) {
                    if (download.progress != null) {
                      // final percent = download.progress! * 100;
                      return const Center(
                          child: Text(
                        // 'loading: ${percent.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey),
                        '',
                      ));
                    }
                    return const Text('');
                  },
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            '${doc[l10n.lang]['name']}',
            style: TextStyle(
              fontSize: (Responsive.isTablet(context)) ? 18 : 13.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
