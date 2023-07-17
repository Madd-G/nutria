import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutria/responsive.dart';

class Article extends StatelessWidget {
  const Article({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
            height: 15.0,
          ),
          itemCount: doc['en'.tr]['article'].length,
          itemBuilder: (context, index) {
            return Text(
              doc['en'.tr]['article'][index],
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: Responsive.isTablet(context) ?  22.0 : 12.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
