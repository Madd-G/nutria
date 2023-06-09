import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';

class DetailObjectScreen extends StatefulWidget {
  // final PredictionModel? data;

  const DetailObjectScreen({
    super.key,
    // this.data,
  });

  @override
  State<DetailObjectScreen> createState() => _DetailObjectScreenState();
}

class _DetailObjectScreenState extends State<DetailObjectScreen> {
  // @override
  // void initState() {
  //   context
  //       .read<SearchBloc>()
  //       .add(SearchItemEvent(searchedWord: widget.data!.className));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: BlocBuilder<SearchBloc, SearchState>(
      //   builder: (context, state) {
      //     if (state is WordExistState) {
      //       var object = state.words[0];
      //       return Center(child: Text(object.name!));
      //     } else if (state is SearchingWordState) {
      //       return const Center(child: LoadingWidget());
      //     } else if (state is ErrorsState) {
      //       return const Center(child: Text('Word not found'));
      //     } else {
      //       return const Center(child: Text('Error'));
      //     }
      //   },
      // ),
      body: Center(
        child: TextButton(
          child: const Text('Home Screen'),
          onPressed: () {
            context.read<ScreenBloc>().add(ScreenEventGoToHomeScreen());
          },
        ),
      ),
    );
  }
}
