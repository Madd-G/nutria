import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class FruitsVegetablesListContent extends StatelessWidget {
  const FruitsVegetablesListContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: 'Fruit',
              ),
              Tab(text: 'Vegetable'),
            ],
          ),
          const SizedBox(
            height: 500,
            child: TabBarView(
              children: [
                FruitContent(),
                VegetableContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
