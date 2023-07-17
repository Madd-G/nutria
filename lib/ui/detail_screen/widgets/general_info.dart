import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../responsive.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({
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
          height: 10.0,
        ),
        itemCount: doc['en'.tr]['general-info'].length,
        itemBuilder: (context, index) {
          return Text(
            doc['en'.tr]['general-info'][index],
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
