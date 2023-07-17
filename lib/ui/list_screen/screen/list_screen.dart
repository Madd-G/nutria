import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../../../responsive.dart';
import '../widgets/widgets.dart';
import '../widgets/search_bar.dart' as search;
import 'package:nutria/blocs/blocs.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key, this.tabIndex}) : super(key: key);

  final int? tabIndex;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late String searched;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_updateText);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _updateText() {
    setState(() {
      searched = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TabBloc tabBloc = context.read<TabBloc>();

    return NutriAIButton(
      mainWidget: DefaultTabController(
        initialIndex: (tabBloc.state is TabStateIsInFruitTab) ? 0 : 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight((Responsive.isTablet(context)) ? 250 : 170.0),
              child: Column(
                children: [
                  // if (Responsive.isTablet(context))
                  //   const SizedBox(
                  //     height: 15.0,
                  //   ),
                  SafeArea(
                    child: Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Fruits and Vegetables'.tr,
                              style: TextStyle(
                                fontFamily: 'GT Maru',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    Responsive.isTablet(context) ? 30 : 20,
                              ),
                            ),
                            const SizedBox(
                              width: 40.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  search.SearchBar(
                    searchController: searchController,
                  ),
                  (searchController.text.isEmpty)
                      ? Material(
                          // color: Colors.white,
                          child: TabBar(
                            indicatorColor:
                                Theme.of(context).colorScheme.onPrimary,
                            // labelColor: (isDarkMode)
                            //     ? Colors.white
                            //     : Colors.black,
                            // unselectedLabelColor: Colors.black,
                            labelColor: Theme.of(context).colorScheme.onPrimary,
                            tabs: [
                              Tab(
                                child: Text('Fruit'.tr,
                                    style: TextStyle(
                                        fontSize: (Responsive.isTablet(context))
                                            ? 25
                                            : 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Tab(
                                child: Text('Vegetable'.tr,
                                    style: TextStyle(
                                        fontSize: (Responsive.isTablet(context))
                                            ? 25
                                            : 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          body: (searchController.text.isEmpty)
              ? const TabBarView(
                  children: [
                    FruitContent(),
                    VegetableContent(),
                  ],
                )
              : FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('items')
                      .where("${'en'.tr}.name",
                          isEqualTo:
                              StringUtils.capitalize(searchController.text))
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("Data not found".tr));
                    }
                    if (snapshot.hasData) {
                      final DocumentSnapshot doc = snapshot.data!.docs[0];
                      return ProductCard(doc: doc);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
        ),
      ),
    );
  }
}
