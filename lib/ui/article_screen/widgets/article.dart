import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/responsive.dart';

import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';

class Article extends StatelessWidget {
  const Article({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
            height: 15.0,
          ),
          itemCount: doc[l10n.lang]['article'].length,
          itemBuilder: (context, index) {
            return Text(
              doc[l10n.lang]['article'][index],
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: Responsive.isMobile(context) ?  12.0 : 22.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
