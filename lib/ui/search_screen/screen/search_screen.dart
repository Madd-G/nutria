import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/ui/detail_screen/screen/detail_screen.dart';
import '../../../models/data_model.dart';
import '../../chat_screen/screen/chat_screen.dart';
import '../widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      mainScreenWidget: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Search'),
          elevation: 0.0,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10,
                  ),
                  child: SearchBar(),
                ),
                BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
                  if (state is SearchInitial) {
                    return const NoWordsSearchedYet();
                  } else if (state is ItemExistState) {
                    return WordsList(state.items!);
                  } else if (state is SearchingItemState) {
                    return const CircularProgressIndicator();
                  } else if (state is NotSearchingItemState) {
                    return const NoWordsSearchedYet();
                  } else if (state is ErrorsState) {
                    return const Center(child: Text('Not found'));
                  } else {
                    return const ErrorWidget();
                  }
                })
              ],
            ),
          ),
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

class WordsList extends StatelessWidget {
  final List<Data> words;

  const WordsList(
    this.words, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: Column(
        children: [
          ...words.map((e) {
            Data dataModel = Data(
                name: e.name,
                description: e.description,
                category: e.category,
                nutrients: e.nutrients,
                benefits: e.benefits);
            return ListTile(
              leading: const Icon(Icons.book),
              title: Text(e.name!),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            data: dataModel,
                          ))),
            );
          })
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const ErrorWidget({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
            child: Text(
              errorMessage ?? "Word not found",
              textAlign: TextAlign.center,
            )));
  }
}

class NoWordsSearchedYet extends StatelessWidget {
  const NoWordsSearchedYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          if (AppConstants.recentWordList.isEmpty)
            const SizedBox(
              height: 40.0,
            ),
          if (AppConstants.recentWordList.isEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.no_accounts,
                  size: 40.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "You have no word here yet",
                )
              ],
            ),
          if (AppConstants.recentWordList.isNotEmpty)
            ...AppConstants.recentWordList.map((e) {
              return PWidgetsWordTile(
                title: e.name.toString(),
                onTap: () {},
              );
            })
        ],
      ),
    );
  }
}

class AppConstants {
  static const double buttonHeight = 50;
  static List<Data> recentWordList = [
    Data(
      name: "",
      description: "",
    )
  ];
}

class PWidgetsWordTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PWidgetsWordTile({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          title: Text(
            title,
          ),
          onTap: () => onTap(),
        ),
        const Divider()
      ],
    );
  }
}
