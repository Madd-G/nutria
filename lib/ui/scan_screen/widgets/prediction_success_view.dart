import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../../models/models.dart';
import '../../screens.dart';
import 'widgets.dart';

class PredictionSuccessView extends StatefulWidget {
  const PredictionSuccessView({
    super.key,
    required this.predictionSuccess,
    required this.predictionModel,
    required this.imagePath,
  });

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

  @override
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var toolbarHeight = 300.0;
    return FloatingDraggableWidget(
      mainScreenWidget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                child: (widget.predictionSuccess.prediction!.isEmpty)
                    ? const SizedBox.shrink()
                    : TabBar(
                        isScrollable: true,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).colorScheme.primary),
                        controller: _controller,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        labelColor: Colors.black,
                        tabs: widget.predictionSuccess.prediction!.map((label) {
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
                      ),
              ),
            ),
          ),
        ),
        body: (widget.predictionSuccess.prediction!.isEmpty)
            ? const Center(child: Text('Not Found'))
            : TabBarView(
                controller: _controller,
                children: widget.predictionSuccess.prediction!.map((e) {
                  return FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('items')
                          .where("name", isEqualTo: e.className)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text("Not Found"));
                        }
                        if (snapshot.hasData) {
                          final DocumentSnapshot doc = snapshot.data!.docs[0];
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(doc.id)
                              .update({'viewed': doc['viewed'] + 1});
                          return ItemInfo(doc: doc);
                        } else {
                          return const SizedBox();
                        }
                      });
                }).toList(),
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
