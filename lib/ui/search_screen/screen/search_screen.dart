import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../../models/data_model.dart';
import '../widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder<SearchBloc, SearchState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.read<ScreenBloc>().add(ScreenEventGoToListScreen());
                },
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
                    returnOnState(state)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget returnOnState(SearchState state) {
    if (state is WordExistState) {
      return WordsList(state.words!);
    } else if (state is SearchingWordState) {
      return const CircularProgressIndicator();
    } else if (state is NotSearchingWordState) {
      return const NoWordsSearchedYet();
    } else if (state is ErrorsState) {
      return const Center(child: Text('Word not found'));
    } else {
      return const ErrorWidget();
    }
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
            return ListTile(
              leading: const Icon(Icons.book),
              title: Text(e.name!),
              onTap: () {
                Data dataModel = Data(
                    name: e.name,
                    description: e.description,
                    category: e.category,
                    nutrients: e.nutrients,
                    benefits: e.benefits);
                context
                    .read<ScreenBloc>()
                    .add(ScreenEventGoToDetailScreen(data: dataModel));
              },
            );
          })
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String? erroMessage;

  const ErrorWidget({super.key, this.erroMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
            child: Text(
              erroMessage ?? "Word not found",
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
          Row(
            children: [
              const Expanded(child: Text("Recent words")),
              if (AppConstants.recentWordList.isNotEmpty)
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "clear all",
                  ),
                )
            ],
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
          onTap: () {
            onTap();
          },
        ),
        const Divider()
      ],
    );
  }
}
