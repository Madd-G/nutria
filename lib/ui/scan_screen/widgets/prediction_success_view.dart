import 'dart:io';

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
    required this.imagePath,
  });

  final Size size;
  final PredictionSuccessState predictionSuccess;
  final List<Prediction> predictionModel;
  final String? imagePath;

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
    if (widget.predictionModel.isNotEmpty) {
      context.read<SearchBloc>().add(SearchItemEvent(
          searchedItem:
              widget.predictionSuccess.prediction![selectedIndex].className));
    }
    _controller = TabController(
        initialIndex: 0,
        length: (widget.predictionModel.isEmpty)
            ? 1
            : widget.predictionModel.length,
        vsync: this);

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
              searchedItem: widget
                  .predictionSuccess.prediction![selectedIndex].className));
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
              searchedItem: widget
                  .predictionSuccess.prediction![selectedIndex].className));
          _tapIsBeingExecuted = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var toolbarHeight = 300.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        flexibleSpace: SizedBox(
          child: Image(
            image: FileImage(File(widget.imagePath!)),
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
                controller: _controller,
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelColor: Colors.black,
                tabs: (widget.predictionSuccess.prediction!.isEmpty)
                    ? [
                        const Tab(
                            height: 0.0,
                            iconMargin: EdgeInsets.only(bottom: 0.0),
                            child: SizedBox.shrink())
                      ]
                    : widget.predictionSuccess.prediction!.map((label) {
                        return Tab(
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
                                  child: Text(label.className))),
                        );
                      }).toList(),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: (widget.predictionSuccess.prediction!.isEmpty)
            ? [
                const Center(
                  child: Text('There Is No Fruit Or Vegetable'),
                ),
              ]
            : widget.predictionSuccess.prediction!.map((e) {
                return BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                  if (state is ItemExistState) {
                    var object = state.items![0];
                    return ItemInfo(
                      size: widget.size,
                      object: object,
                    );
                  } else if (state is SearchingItemState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorsState) {
                    context.read<SearchBloc>().add(SearchItemEvent(
                        searchedItem: widget.predictionSuccess
                            .prediction![selectedIndex].className));
                    return const Center(child: Text('There is no information'));
                  } else {
                    return const Center(child: Text('Else'));
                  }
                });
              }).toList(),
      ),
    );
  }
}
