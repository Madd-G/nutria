import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import '../../chat_screen/screen/chat_screen.dart';
import '../widgets/widgets.dart';
import 'package:nutria/blocs/blocs.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key, this.tabIndex}) : super(key: key);

  final int? tabIndex;

  @override
  Widget build(BuildContext context) {
    final TabBloc tabBloc = context.read<TabBloc>();

    return FloatingDraggableWidget(
      mainScreenWidget: DefaultTabController(
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
          // floatingActionButton: const NutriAIButton(),
        ),
      ),
      floatingWidget: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
          tooltip: 'Hello, may I help you?',
          onPressed: () {
            if (FirebaseAuth.instance.currentUser?.uid == null) {
              context.read<AuthCubit>().signInWithGoogle(context);
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/AI.png',
            ),
          )),
      floatingWidgetWidth: 55,
      floatingWidgetHeight: 55,
    );
  }
}
