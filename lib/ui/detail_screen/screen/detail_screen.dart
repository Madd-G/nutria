import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutria/responsive.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../widgets/widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('items')
        .doc(widget.doc.id)
        .update({'${'en'.tr}.viewed': widget.doc['en'.tr]['viewed'] + 1});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabBarViewList = [
      GeneralInfo(doc: widget.doc),
      Characteristics(doc: widget.doc),
      NutrientInfo(doc: widget.doc),
      BenefitInfo(doc: widget.doc),
    ];
    List<String> tabsList = [
      'General Information'.tr,
      'Characteristics'.tr,
      'Nutrition'.tr,
      'Benefits'.tr
    ];

    double toolbarHeight = (Responsive.isTablet(context)) ? 500.0 : 320.0;
    return DefaultTabController(
      length: tabsList.length,
      child: NutriAIButton(
        mainWidget: Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              children: [
                SizedBox(
                  height: (Responsive.isTablet(context)) ? 510 : 330.0,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: widget.doc['en'.tr]['item-image'],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.5)),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            toolbarHeight: toolbarHeight,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(50),
                    //   color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 1),
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  child: TabBar(
                    isScrollable: true,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    // unselectedLabelColor: Theme.of(context),
                    labelColor: Colors.white,
                    // unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    // indicator: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(50),
                    //   color: Theme.of(context).colorScheme.primary,
                    // ),
                    indicatorColor: Colors.white,
                    // labelColor: Theme.of(context).colorScheme.primary,
                    tabs: tabsList
                        .map<Widget>(
                          (tabName) => Tab(
                            height:
                                (Responsive.isTablet(context)) ? 38.0 : 30.0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                tabName,
                                style: TextStyle(
                                    // color: Colors.red,
                                    fontSize: (Responsive.isTablet(context))
                                        ? 23.0
                                        : 13.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
              children: tabBarViewList.map<Widget>((e) => e).toList()),
        ),
      ),
    );
  }
}
