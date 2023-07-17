import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/responsive.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../../../utils/controller/language_controller.dart';
import '../../../models/models.dart';
import 'widgets.dart';

class PredictionSuccessView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final controller = Get.put(LanguageController());
    Size size = MediaQuery.of(context).size;
    var toolbarHeight = (Responsive.isTablet(context)) ? 420.0 : 300.0;
    return NutriAIButton(
      mainWidget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: (Responsive.isTablet(context)) ? 435.0 : 310.0,
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
                                          child: Icon(Icons.close)),
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
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.black, width: 1),
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: (predictionSuccess.prediction!.isEmpty)
                    ? const SizedBox.shrink()
                    : TabBar(
                        isScrollable: true,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                        // unselectedLabelColor: Theme.of(context).colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        // indicator: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(50),
                        //     color: Theme.of(context).colorScheme.primary),
                        // indicatorColor: Theme.of(context).colorScheme.primary,
                        indicatorColor: Colors.white,
                        // labelColor: Colors.black,
                        tabs: predictionSuccess.prediction!
                            .map(
                              (label) => Tab(
                                height: (Responsive.isTablet(context))
                                    ? 40.0
                                    : 30.0,
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
                                    child: Text(
                                      (controller.selectedLanguage == 'English')
                                          ? label.className.tr
                                          : label.className,
                                      style: TextStyle(
                                          fontSize:
                                              (Responsive.isTablet(context))
                                                  ? 25.0
                                                  : 12.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ),
        ),
        body: (predictionSuccess.prediction!.isEmpty)
            ? Center(
                child: Text('No fruits/vegetables detected'.tr),
              )
            : TabBarView(
                children: predictionSuccess.prediction!.map(
                  (e) {
                    return FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('items')
                          .where("ind.name", isEqualTo: e.className)
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
                          return Center(
                              child: Text("No fruits/vegetables detected".tr));
                        }
                        if (snapshot.hasData) {
                          final DocumentSnapshot doc = snapshot.data!.docs[0];
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(doc.id)
                              .update({
                            '${'en'.tr}.viewed': doc['en'.tr]['viewed'] + 1
                          });
                          return ItemInfo(doc: doc);
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
