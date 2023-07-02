import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class BenefitInfo extends StatelessWidget {
  const BenefitInfo({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
          height: 15.0,
        ),
        itemCount: doc['benefits'].length,
        itemBuilder: (context, index) {
          return Text(
            doc['benefits'][index],
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: (Responsive.isTablet(context)) ? 22.0 : 11.0,
            ),
          );
        },
      ),
    );
  }
}
