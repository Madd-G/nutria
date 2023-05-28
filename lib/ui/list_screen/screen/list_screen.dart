import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:nutria/blocs/blocs.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30.0,
          ),
          onPressed: () {
            context.read<ScreenBloc>().add(ScreenEventGoToHomeScreen());
          },
        ),
        title: const Text('Fruits and Vegetables'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [SearchBar(), FruitsVegetablesListContent()],
        ),
      ),
    );
  }
}
