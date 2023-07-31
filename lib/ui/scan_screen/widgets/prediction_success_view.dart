import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutria/responsive.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../../../models/models.dart';
import 'widgets.dart';

class PredictionSuccessView extends StatelessWidget {
  const PredictionSuccessView({
    super.key,
    required this.predictionModel,
    required this.imagePath,
    required this.l10n,
  });

  final List<Prediction> predictionModel;
  final String? imagePath;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var toolbarHeight = (Responsive.isMobile(context)) ? 300.0 : 420.0;
    return NutriAIButton(
      mainWidget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: (Responsive.isMobile(context)) ? 310.0 : 435.0,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.all(8.0),
                            content: Stack(
                              children: [
                                SizedBox(
                                  height: size.height * 0.5,
                                  width: size.width * 0.9,
                                  child: Image(
                                    image: FileImage(File(imagePath!)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 22,
                                  left: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Image(
                    image: FileImage(File(imagePath!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 12,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                    child: const Center(
                        child: Icon(Icons.arrow_back_ios_new_outlined)),
                  ),
                ),
              )
            ],
          ),
          toolbarHeight: toolbarHeight,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: const Border(
                    top: BorderSide(color: Colors.black, width: 1),
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: (predictionModel.isEmpty)
                    ? const SizedBox.shrink()
                    : TabBar(
                        isScrollable: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 2.0),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        // unselectedLabelColor: Theme.of(context).colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        // indicator: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(50),
                        //     color: Theme.of(context).colorScheme.primary),
                        // indicatorColor: Theme.of(context).colorScheme.primary,
                        indicatorColor: Colors.white,
                        // labelColor: Colors.black,
                        tabs: predictionModel.map((item) {
                          return FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('items')
                                .where("ind.name", isEqualTo: item.className)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox.shrink();
                              }
                              if (snapshot.data!.docs.isEmpty) {
                                return Text(l10n.noFruitVegetable);
                              }
                              if (snapshot.hasData) {
                                final DocumentSnapshot doc =
                                    snapshot.data!.docs[0];
                                FirebaseFirestore.instance
                                    .collection('items')
                                    .doc(doc.id);
                                return Tab(
                                  height: (Responsive.isMobile(context))
                                      ? 25.0
                                      : 40.0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      doc[l10n.lang]['name'],
                                      style: TextStyle(
                                          fontSize:
                                              (Responsive.isMobile(context))
                                                  ? 10.0
                                                  : 23.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                );
                                // return ItemInfo(
                                //   doc: doc,
                                //   l10n: l10n,
                                // );
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        }
                            //     Tab(
                            //   height: (Responsive.isMobile(context))
                            //       ? 25.0
                            //       : 40.0,
                            //   child: Align(
                            //     alignment: Alignment.center,
                            //     child: Text(
                            //       // (controller.selectedLanguage == 'English')
                            //       //     ? label.className.tr
                            //       //     :
                            //       label.className,
                            //       style: TextStyle(
                            //           fontSize:
                            //               (Responsive.isMobile(context))
                            //                   ? 15.0
                            //                   : 25.0,
                            //           fontWeight: FontWeight.w700),
                            //     ),
                            //   ),
                            // ),
                            ).toList(),
                      ),
              ),
            ),
          ),
        ),
        body: (predictionModel.isEmpty)
            ? Center(
                child: Text(l10n.noFruitVegetable),
              )
            : TabBarView(
                children: predictionModel.map(
                  (item) {
                    return FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('items')
                          .where("ind.name", isEqualTo: item.className)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                              height: MediaQuery.of(context).size.width * 0.17,
                              child:
                                  Lottie.asset('assets/animation/loading.json'),
                            ),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(child: Text(l10n.noFruitVegetable));
                        }
                        if (snapshot.hasData) {
                          final DocumentSnapshot doc = snapshot.data!.docs[0];
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(doc.id)
                              .update({
                            '${l10n.lang}.viewed': doc[l10n.lang]['viewed'] + 1
                          });
                          return ItemInfo(
                            doc: doc,
                            l10n: l10n,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  },
                ).toList(),
              ),
      ),
    );
  }
}
