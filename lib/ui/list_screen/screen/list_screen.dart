import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:nutria/blocs/blocs.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key, this.tabIndex}) : super(key: key);

  final int? tabIndex;

  @override
  Widget build(BuildContext context) {
    final TabBloc tabBloc = context.read<TabBloc>();

    return DefaultTabController(
      initialIndex: (tabBloc.state is TabStateIsInFruitTab) ? 0 : 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
            // onPressed: () => Navigator.pop(context),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Fruits and Vegetables'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200.0),
            child: Column(
              children: [
                const SearchBar(),
                Material(
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    labelColor: Colors.black,
                    tabs: const [
                      Tab(text: 'Fruit'),
                      Tab(text: 'Vegetable'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            FruitContent(),
            VegetableContent(),
          ],
        ),
      ),
    );
  }
}
