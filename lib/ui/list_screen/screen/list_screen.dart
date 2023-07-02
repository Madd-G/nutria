import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/widgets/nutriai_button.dart';
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
                      child: Text(
                        'Buah dan Sayuran',
                        style: TextStyle(
                          fontFamily: 'GT Maru',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: Responsive.isTablet(context) ? 30 : 15,
                        ),
                      ),
                    ),
                  ),
                  search.SearchBar(
                    searchController: searchController,
                  ),
                  (searchController.text.isEmpty)
                      ? Material(
                          color: Colors.white,
                          child: TabBar(
                            indicatorColor:
                                Theme.of(context).colorScheme.primary,
                            unselectedLabelColor: Colors.black,
                            labelColor: Theme.of(context).colorScheme.primary,
                            tabs: [
                              Tab(
                                child: Text('Buah',
                                    style: TextStyle(
                                        fontSize: (Responsive.isTablet(context))
                                            ? 25
                                            : 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Tab(
                                child: Text('Sayuran',
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
                      .where("name",
                          isEqualTo:
                              StringUtils.capitalize(searchController.text))
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("Data tidak ditemukan"));
                    }
                    if (snapshot.hasData) {
                      final DocumentSnapshot doc = snapshot.data!.docs[0];
                      return ProductCard(doc: doc);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
          // floatingActionButton: const NutriAIButton(),
        ),
      ),
    );
  }
}
