import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/ui/home_screen/widgets/widgets.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../../../utils/custom_scroll/custom_scroll.dart';
import '../../detail_screen/screen/detail_screen.dart';
import 'article_recommendation.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key, required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    10.0,
                    Responsive.isMobile(context) ? 6.0 : 12.0,
                    10.0,
                    Responsive.isMobile(context) ? 0.0 : 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.recommendation,
                      style: TextStyle(
                        fontSize: (Responsive.isMobile(context)) ? 12.0 : 30.0,
                        fontWeight: FontWeight.w600,
                        // color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            l10n.todaysRecommendation,
                            style: TextStyle(
                              fontSize:
                                  (Responsive.isMobile(context)) ? 10.0 : 18.0,
                              fontWeight: FontWeight.w600,
                              // color: Colors.grey,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .orderBy('${l10n.lang}.viewed', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: (Responsive.isMobile(context)) ? 180 : 220,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return SizedBox(
                      child: Center(
                        child: Text(l10n.thereIsNoData),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    final ScrollController controller = ScrollController();

                    return SizedBox(
                      height: (Responsive.isMobile(context)) ? 180 : 215,
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: ListView.builder(
                          controller: controller,
                          padding: const EdgeInsets.all(0.0),
                          reverse: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
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
                                child: RecommendationCard(
                                  doc: doc,
                                  l10n: l10n,
                                ));
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        ArticleRecommendation(
          l10n: l10n,
        ),
      ],
    );
  }
}
