import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doc['en'.tr]['name'],
                  style: TextStyle(
                      fontSize: (Responsive.isTablet(context)) ? 40.0 : 23.0,
                      fontWeight: FontWeight.w900),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 25.0),
                    child: Text(
                      doc['en'.tr]['category'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: (Responsive.isTablet(context)) ? 30.0 : 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Nutrients and minerals'.tr,
              style: TextStyle(
                  fontSize: (Responsive.isTablet(context)) ? 30.0 : 14.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: doc['en'.tr]['nutrients'].map<Widget>(
                (label) {
                  return GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          context.read<ChatGPTBloc>().add(GetResult(
                              message:
                                  '${'Definition and benefits of consuming foods that contain'.tr} $label'));
                          return AlertDialog(
                            insetPadding: const EdgeInsets.all(8.0),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.close),
                                ),
                                Text(
                                  label,
                                  style: TextStyle(
                                      fontSize: (Responsive.isTablet(context))
                                          ? 35.0
                                          : 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 50.0,
                                ),
                              ],
                            ),
                            content: BlocBuilder<ChatGPTBloc, ChatGPTState>(
                              builder: (context, state) {
                                if (state is ChatGPTIsSuccess) {
                                  return SizedBox(
                                    width: size.width * 0.8,
                                    height: size.height * 0.7,
                                    child: SingleChildScrollView(
                                      child: AnimatedTextKit(
                                        isRepeatingAnimation: true,
                                        repeatForever: false,
                                        displayFullTextOnTap: true,
                                        totalRepeatCount: 1,
                                        animatedTexts: [
                                          TyperAnimatedText(state.result,
                                              textStyle: TextStyle(
                                                  fontSize:
                                                      (Responsive.isTablet(
                                                              context))
                                                          ? 30.0
                                                          : 15.0)),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    width: size.width * 0.8,
                                    height: size.height * 0.7,
                                    child: SpinKitThreeBounce(
                                      color: Colors.black,
                                      size: (Responsive.isTablet(context))
                                          ? 25.0
                                          : 18,
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 2.0),
                          child: Center(
                              child: Text(
                            label,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: (Responsive.isTablet(context))
                                    ? 25.0
                                    : 9.0),
                            softWrap: false,
                            textAlign: TextAlign.center,
                          )),
                        )),
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Text(
              'Description'.tr,
              style: TextStyle(
                  fontSize: (Responsive.isTablet(context)) ? 30.0 : 14.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 3.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10.0,
              ),
              itemCount: doc['en'.tr]['general-info'].length,
              itemBuilder: (context, index) {
                return Text(
                  doc['en'.tr]['general-info'][index],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (Responsive.isTablet(context)) ? 22.0 : 13.0,
                  ),
                );
              },
            ),
            Text(
              '${'Benefits of consuming'.tr} ${doc['en'.tr]['name']}',
              style: TextStyle(
                  fontSize: (Responsive.isTablet(context)) ? 30.0 : 14.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10.0,
              ),
              itemCount: doc['en'.tr]['benefits'].length,
              itemBuilder: (context, index) {
                return Text(
                  doc['en'.tr]['benefits'][index],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (Responsive.isTablet(context)) ? 22.0 : 13.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
