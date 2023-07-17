import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../responsive.dart';

class ArticleTitle extends StatelessWidget {
  const ArticleTitle({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Text(
      doc['en'.tr]['title'],
      style: TextStyle(
          fontSize: (Responsive.isTablet(context)) ? 28.0 : 18.0,
          fontWeight: FontWeight.w700),
    );
  }
}
