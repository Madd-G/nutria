import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: size.height * 0.32,
              width: size.width,
              child: CachedNetworkImage(
                imageUrl: doc[l10n.lang]['item-image'],
                fit: BoxFit.fill,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
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
