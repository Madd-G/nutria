import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../responsive.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({
    super.key,
    required this.doc,
    required this.l10n,
  });

  final DocumentSnapshot doc;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10.0,
        ),
        itemCount: doc[l10n.lang]['general-info'].length,
        itemBuilder: (context, index) {
          return Text(
            doc[l10n.lang]['general-info'][index],
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: (Responsive.isTablet(context)) ? 22.0 : 13.0,
            ),
          );
        },
      ),
    );
  }
}
