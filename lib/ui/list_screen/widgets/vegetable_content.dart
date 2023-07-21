import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutria/ui/list_screen/widgets/widgets.dart';

import '../../../responsive.dart';

class VegetableContent extends StatelessWidget {
  const VegetableContent({super.key, required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('items')
            .where("${l10n.lang}.category", isEqualTo: l10n.vegetable)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.17,
                height: MediaQuery.of(context).size.width * 0.17,
                child: Lottie.asset('assets/animation/loading.json'),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return SizedBox(
              child: Center(
                child: Text(l10n.dataNotFound),
              ),
            );
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var doc = documents[index];
                  return ProductCard(doc: doc, l10n: l10n,);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (Responsive.isMobile(context)) ? 2 : 3,
                  childAspectRatio: 9/7,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
