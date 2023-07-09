import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../../../responsive.dart';
import '../widgets/widgets.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NutriAIButton(
      screenHeight: MediaQuery.of(context).size.height * 0.95,
      mainWidget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight((Responsive.isTablet(context))
                ? size.height * 0.15
                : size.height * 0.12),
            child: Column(
              children: [
                Container(
                  height: (Responsive.isTablet(context))
                      ? MediaQuery.of(context).size.height * 0.15
                      : MediaQuery.of(context).size.height * 0.15,
                  color: Theme.of(context).colorScheme.primary,
                  child: Lottie.asset(
                    'assets/animation/articles.json',
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
              return const SizedBox(
                child: Center(child: Text("Tidak ada data")),
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
