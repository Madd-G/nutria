import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutria/ui/article_screen/widgets/article_list_card.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';
import '../../screens.dart';

class ArticleRecommendation extends StatelessWidget {
  const ArticleRecommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: (Responsive.isTablet(context)) ? 20 : 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Today\'s article recommendation'.tr,
                  style: TextStyle(
                    fontSize: (Responsive.isTablet(context)) ? 18 : 13,
                    fontWeight: FontWeight.w600,
                    // color: Colors.grey,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<BottomNavBarBloc>()
                      .add(EventGoToArticleScreen());
                },
                child: Text(
                  'See All'.tr,
                  style: TextStyle(
                    fontSize: (Responsive.isTablet(context)) ? 18 : 13.0,
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
                .orderBy('${'en'.tr}.viewed', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return SizedBox(
                  child: Center(
                    child: Text("There is no data".tr),
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
                                builder: (context) => DetailScreen(doc: doc),
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
