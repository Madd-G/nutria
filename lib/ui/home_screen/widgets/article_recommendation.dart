import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/ui/article_screen/widgets/article_list_card.dart';
import '../../../blocs/blocs.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../../screens.dart';

class ArticleRecommendation extends StatelessWidget {
  const ArticleRecommendation({
    super.key, required this.l10n,
  });

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: (Responsive.isMobile(context)) ? 0 : 20,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.todaysArticle,
                  style: TextStyle(
                    fontSize: (Responsive.isMobile(context)) ? 10 : 18,
                    fontWeight: FontWeight.w600,
                    // color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4.0,),
              GestureDetector(
                onTap: () {
                  context
                      .read<BottomNavBarBloc>()
                      .add(EventGoToArticleScreen());
                },
                child: Text(
                  l10n.seeAll,
                  style: TextStyle(
                    fontSize: (Responsive.isMobile(context)) ? 10.0 : 18.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('article')
                .orderBy('${l10n.lang}.viewed', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return SizedBox(
                  child: Center(
                    child: Text(l10n.thereIsNoData),
                  ),
                );
              }
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                  reverse: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    var doc = documents[index];
                    return GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  doc: doc,
                                  l10n: l10n,
                                ),
                              ),
                            ),
                        child: ArticleListCard(
                          doc: doc,
                        ));
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
