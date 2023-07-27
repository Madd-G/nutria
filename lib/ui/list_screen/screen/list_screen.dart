import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
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
    final AppLocalizations l10n = AppLocalizations.of(context)!;
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
                  Size.fromHeight((Responsive.isMobile(context)) ? 170 : 250.0),
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
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                              l10n.fruitVegetable,
                              style: TextStyle(
                                fontFamily: 'GT Maru',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    Responsive.isMobile(context) ? 20 : 30,
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
                    l10n: l10n,
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
                                child: Text(l10n.fruit,
                                    // key: const Key('dark theme test'),
                                    key: const Key('fruit_tab'),
                                    style: TextStyle(
                                        fontSize: (Responsive.isMobile(context))
                                            ? 14
                                            : 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Tab(
                                child: Text(l10n.vegetable,
                                    key: const Key('vegetable_tab'),
                                    style: TextStyle(
                                        fontSize: (Responsive.isMobile(context))
                                            ? 14
                                            : 20,
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
              ? TabBarView(
                  children: [
                    FruitContent(l10n: l10n),
                    VegetableContent(l10n: l10n),
                  ],
                )
              : FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('items')
                      .where("${l10n.lang}.name",
                          isEqualTo:
                              StringUtils.capitalize(searchController.text))
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Text(
                        l10n.dataNotFound,
                        textAlign: TextAlign.center,
                      ));
                    }
                    if (snapshot.hasData) {
                      final DocumentSnapshot doc = snapshot.data!.docs[0];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                            height: 200.0,
                            child: ProductCard(doc: doc, l10n: l10n)),
                      );
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
