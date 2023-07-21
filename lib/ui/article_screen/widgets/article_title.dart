import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';

class ArticleTitle extends StatelessWidget {
  const ArticleTitle({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return Text(
      doc[l10n.lang]['title'],
      style: TextStyle(
          fontSize: (Responsive.isTablet(context)) ? 28.0 : 18.0,
          fontWeight: FontWeight.w700),
    );
  }
}
