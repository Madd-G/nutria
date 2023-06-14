import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../../models/prediction_model.dart';
import '../../scan_screen/widgets/item_info.dart';

class HistorySuccessScreen extends StatefulWidget {
  const HistorySuccessScreen(
      {super.key,
      required this.size,
      required this.historySuccess,
      required this.historyModel});

  final Size size;
  final HistorySuccessState historySuccess;
  final List<Prediction> historyModel;

  @override
  State<HistorySuccessScreen> createState() => _HistorySuccessScreenState();
}

class _HistorySuccessScreenState extends State<HistorySuccessScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int selectedIndex = 0;
  bool _swipeIsInProgress = false;
  bool _tapIsBeingExecuted = false;

  @override
  void initState() {
    super.initState();
    if (widget.historyModel.isNotEmpty) {
      context.read<SearchBloc>().add(SearchItemEvent(
          searchedWord:
              widget.historySuccess.historyModel[selectedIndex].className));
    }
    _controller = TabController(
        initialIndex: 0,
        length: (widget.historyModel.isEmpty) ? 1 : widget.historyModel.length,
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
              searchedWord: widget
                  .historySuccess.historyModel[selectedIndex].className));
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
                  .historySuccess.historyModel[selectedIndex].className));
          _tapIsBeingExecuted = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screenBloc = context.read<ScreenBloc>();
    // final firestore = FirebaseFirestore.instance;
    // final user = FirebaseAuth.instance.currentUser;
    // final tilesList = <ListTile>[];
    // final histsList = <ListTile>[];
    // Map myHistory = {};
    // Future getDocs(List<QueryDocumentSnapshot<Object?>> datas) async {
    //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user?.uid)
    //       .collection('history')
    //       .get();
    //   for (int i = 0; i < querySnapshot.docs.length; i++) {
    //     var a = querySnapshot.docs[i];
    //     var da = datas[i].id;
    //     print(a.id.runtimeType);
    //     print(da.runtimeType);
    //     // print('datas isi 3 ${datas[0].get(da)}');
    //   }
    // }

    // return Scaffold(
    //     appBar: AppBar(
    //       leading: IconButton(
    //         icon: const Icon(Icons.arrow_back_ios),
    //         onPressed: () {
    //           screenBloc.add(ScreenEventGoToProfileScreen());
    //         },
    //       ),
    //       title: const Text('History'),
    //       elevation: 0.0,
    //     ),
    //     body: BlocBuilder<HistoryBloc, HistoryState>(
    //       builder: (context, state) {
    //         if (state is HistorySuccessState) {
    //           return ListView(
    //               children: state.historyModel!.map((label) {
    //                 return Text(label.className);
    //               })
    //           );
    //         } else {
    //           return Container()
    //         }
    //         // return ListView(
    //         //   children: tilesList,
    //         // );
    //       },
    //     );
    //   // FutureBuilder(
    //   //     future: FirebaseFirestore.instance
    //   //         .collection('users')
    //   //         .doc(user?.uid)
    //   //         .collection('history')
    //   //         .get()
    //   //         .then((value) {
    //   //       // final tilesList = <ListTile>[];
    //   //       print('value: ${value.docs}');
    //   //       print('value 0: ${value.docs[0].get('objects')}');
    //   //       // print('value 1: ${value.docs[0].get('objects')[0]}');
    //   //       // print('value 2: ${value.docs[0].get('objects')[1]}');
    //   //
    //   //       List<History> hists = historyModelFromJson(value.docs[0].get('objects'));
    //   //       // for (int i = 0; i < hists.length; i++) {
    //   //       //   print('hists[i].className: ${hists[i].className}');
    //   //       // }
    //   //       // for (var a in value.docs[0].get('objects')) {
    //   //       //   print(a.data());
    //   //       //     final nextHistory = History.fromJson((Map<String, dynamic>.from(a.data())));
    //   //       //     final orderTile = ListTile(
    //   //       //         leading: const Icon(Icons.add),
    //   //       //         title: Text('${nextHistory.className}'),
    //   //       //         subtitle: Text('${nextHistory.confidence}'));
    //   //       //     print('nextHistory.className: ${nextHistory.className}');
    //   //       //     print('nextHistory.confidence: ${nextHistory.confidence}');
    //   //       //     tilesList.add(orderTile);
    //   //       //     print('tilesList.length: ${tilesList.length}');
    //   //       // }
    //   //       // for (var a in hists) {
    //   //       //   final myHistory = Map<String, dynamic>.from(a.data());
    //   //       // }
    //   //       // var his = historyModelToJson(hists);
    //   //       // his.forEach((key, value) {
    //   //       //   final nextHistory = History.fromRTDB((Map<String, dynamic>.from(value)));
    //   //       //   final orderTile = ListTile(
    //   //       //       leading: const Icon(Icons.add),
    //   //       //       title: Text('${nextHistory.className}'),
    //   //       //       subtitle: Text('${nextHistory.confidence}'));
    //   //       //   tilesList.add(orderTile);
    //   //       //   print('tilesList.length: ${tilesList.length}');
    //   //       // });
    //   //       // for (var a in value.docs) {
    //   //       //   print(a.data());
    //   //       //   print(a.data().runtimeType);
    //   //       //   var dat = Map<String, dynamic>.from(a.data());
    //   //       //   print('dat $dat');
    //   //
    //   //       // }
    //   //     }),
    //   //     builder: (context, snapshot) {
    //   //       // if (snapshot.hasData) {
    //   //       print('tilesList.length: ${tilesList.length}');
    //   //       // final tilesList = <ListTile>[];
    //   //
    //   //       // final myHistory =
    //   //       //     Map<String, dynamic>.from(snapshot.data as Map);
    //   //       // myHistory.forEach((key, value) {
    //   //       //   final nextHistory =
    //   //       //       History.fromRTDB((Map<String, dynamic>.from(value)));
    //   //       //   final orderTile = ListTile(
    //   //       //       leading: const Icon(Icons.add),
    //   //       //       title: Text('${nextHistory.className}'),
    //   //       //       subtitle: Text('${nextHistory.confidence}'));
    //   //       //   tilesList.add(orderTile);
    //   //       // });
    //   //       return BlocBuilder<HistoryBloc, HistoryState>(
    //   //         builder: (context, state) {
    //   //           if (state is HistorySuccessState) {
    //   //             return ListView(
    //   //               children: state.historyModel!.map((label) {
    //   //                 return Text(label.className);
    //   //               })
    //   //             );
    //   //           } else {
    //   //             return Container()
    //   //           }
    //   //           // return ListView(
    //   //           //   children: tilesList,
    //   //           // );
    //   //         },
    //   //       );
    //   //       // } else {
    //   //       //   print('else: ${tilesList.length}');
    //   //       //   return Container(
    //   //       //     color: Colors.red,
    //   //       //     height: 100.0,
    //   //       //     width: 100.0,
    //   //       //   );
    //   //       // }
    //   //     }
    //   //     // List<QueryDocumentSnapshot<Object?>> datas = snapshot.data!.docs;
    //   //     // var dat = Map<String, dynamic>.from(datas[0].data() as Map);
    //   //     // print('dat $dat');
    //   //     // print('datas isi 4 ${datas[0].get('objects')[0]['className']}');
    //   //     // List<dynamic>? historyList;
    //   //     //
    //   //     // FirebaseFirestore.instance
    //   //     //     .collection('users')
    //   //     //     .doc(user?.uid)
    //   //     //     .collection('history')
    //   //     //     .doc('euN3m5diA6pum0zZloYT')
    //   //     //     .get()
    //   //     //     .then((value) {
    //   //     //   historyList = value.data()!['objects'];
    //   //     //   print('historyList: $historyList');
    //   //     //   print('historyList[]: ${historyList![0]}');
    //   //     //   print('historyList[]: ${historyList![1]['className']}');
    //   //     //   for (var hist in historyList!) {
    //   //     //     List<HistoryCard> historyCards = [];
    //   //     //
    //   //     //     final className = hist[0]['className'];
    //   //     //     final historyData = HistoryCard(
    //   //     //       name: className,
    //   //     //     );
    //   //     //     historyCards.add(historyData);
    //   //     //   }
    //   //     // });
    //   //     // return Container(
    //   //     //   color: Colors.red,
    //   //     //   height: 100,
    //   //     //   width: 50,
    //   //     // );
    //   //     // ListView(
    //   //     //   children: historyCards,
    //   //     // );
    //   //     ),
    // );
    var toolbarHeight = 300.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        flexibleSpace: const SizedBox(
          child: Image(
            image: AssetImage("assets/images/apples.png"),
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
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is HistorySuccessState) {
                    return TabBar(
                      isScrollable: true,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.primary,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.primary),
                      // controller: _controller,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      labelColor: Colors.black,
                      tabs: (widget.historySuccess.historyModel.isEmpty)
                          ? [
                              const Tab(
                                  height: 0.0,
                                  iconMargin: EdgeInsets.only(bottom: 0.0),
                                  child: SizedBox.shrink())
                            ]
                          : widget.historySuccess.historyModel.map((label) {
                              return Tab(
                                height: 30.0,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            width: 1)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(label.className))),
                              );
                            }).toList(),
                    );
                  } else {
                    return Container(
                        color: Colors.red, height: 10.0, width: 40.0);
                  }
                },
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: (widget.historySuccess.historyModel.isEmpty)
            ? [
                const Center(
                  child: Text('There Is No Fruit Or Vegetable'),
                ),
              ]
            : widget.historySuccess.historyModel.map((e) {
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
                    context.read<SearchBloc>().add(SearchItemEvent(
                        searchedWord: widget.historySuccess
                            .historyModel[selectedIndex].className));
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

class HistoryCard extends StatelessWidget {
  final String name;

  const HistoryCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: Text(name),
    );
  }
}
