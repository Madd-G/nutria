import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../../models/models.dart';
import 'widgets.dart';

class PredictionSuccessView extends StatefulWidget {
  const PredictionSuccessView({
    super.key,
    required this.size,
    required this.predictionSuccess,
    required this.predictionModel,
  });

  final Size size;
  final PredictionSuccessState predictionSuccess;
  final List<PredictionModel> predictionModel;

  @override
  State<PredictionSuccessView> createState() => _PredictionSuccessViewState();
}

class _PredictionSuccessViewState extends State<PredictionSuccessView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int selectedIndex = 0;
  bool _swipeIsInProgress = false;
  bool _tapIsBeingExecuted = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        initialIndex: 0, length: widget.predictionModel.length, vsync: this);

    _controller?.animation?.addListener(() {
      if (!_tapIsBeingExecuted &&
          !_swipeIsInProgress &&
          (_controller!.offset >= 0.5 || _controller!.offset <= -0.5)) {
        int newIndex = _controller!.offset > 0
            ? _controller!.index + 1
            : _controller!.index - 1;

        _swipeIsInProgress = true;
        setState(() {
          selectedIndex = newIndex;
          context.read<SearchBloc>().add(SearchItemEvent(
              searchedWord: widget
                  .predictionSuccess.predictionModel[selectedIndex].className));
        });
      }
    });
    _controller!.addListener(() {
      _swipeIsInProgress = false;
      setState(() {
        selectedIndex = _controller!.index;
      });
      if (_tapIsBeingExecuted == true) {
        _tapIsBeingExecuted = false;
      } else {
        if (_controller!.indexIsChanging) {
          context.read<SearchBloc>().add(SearchItemEvent(
              searchedWord: widget
                  .predictionSuccess.predictionModel[selectedIndex].className));
          _tapIsBeingExecuted = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage("assets/images/fruit.png"),
          fit: BoxFit.cover,
        ),
        toolbarHeight: 230.0,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Material(
            color: Colors.white,
            child: TabBar(
              // isScrollable: true,
              controller: _controller,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Colors.black,
              tabs: widget.predictionSuccess.predictionModel.map((e) {
                return Text(e.className);
              }).toList(),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            child: TabBarView(
              controller: _controller,
              children: widget.predictionSuccess.predictionModel.map((e) {
                return BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is WordExistState) {
                        var object = state.words![0];
                        return ItemInfo(
                          size: widget.size,
                          object: object,
                        );
                      } else if (state is SearchingWordState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ErrorsState) {
                        return const Center(child: Text('There is no information'));
                      } else {
                        return const Center(child: Text('Else'));
                      }
                    });
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}