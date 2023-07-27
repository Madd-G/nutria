import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../widgets/widgets.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return NutriAIButton(
      screenHeight: MediaQuery.of(context).size.height * 0.95,
      mainWidget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight((Responsive.isMobile(context))
                ? size.height * 0.12
                : size.height * 0.15),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: Theme.of(context).colorScheme.primary,
                  child: Lottie.asset(
                    'assets/animation/articles.json',
                    repeat: false,
                  ),
                ),
                Container(
                  height: 10.0,
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('article').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return SizedBox(
                child: Center(child: Text(l10n.thereIsNoData)),
              );
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ArticleList(docs: documents);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
