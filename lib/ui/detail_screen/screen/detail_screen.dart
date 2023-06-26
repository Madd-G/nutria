import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/widgets/nutriai_button.dart';
import '../../scan_screen/widgets/characteristics.dart';
import '../../scan_screen/widgets/general_info.dart';
import '../../scan_screen/widgets/benefit_info.dart';
import '../../scan_screen/widgets/nutrient_info.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TabController? _tabController;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('items')
        .doc(widget.doc.id)
        .update({'viewed': widget.doc['viewed'] + 1});
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
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
      'Informasi Umum',
      'Karakteristik',
      'Gizi',
      'Manfaat'
    ];

    var toolbarHeight = 300.0;
    return DefaultTabController(
      length: tabsList.length,
      child: NutriAIButton(
        mainWidget: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: SizedBox(
              child: Image(
                image: NetworkImage(widget.doc['item-image']),
                fit: BoxFit.cover,
              ),
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
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: TabBar(
                    isScrollable: true,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                    unselectedLabelColor: Theme.of(context).colorScheme.primary,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.primary),
                    controller: _tabController,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    labelColor: Colors.black,
                    tabs: tabsList
                        .map<Widget>(
                          (tabName) => Tab(
                            height: 30.0,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  tabName,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
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
              controller: _tabController,
              children: tabBarViewList.map<Widget>((e) => e).toList()),
        ),
      ),
    );
  }
}
