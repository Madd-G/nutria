import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';

class NutrientInfo extends StatelessWidget {
  const NutrientInfo({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isTablet(context))
              const SizedBox(
                height: 12.0,
              ),
            Text(
              '${'List of general nutrition information for'.tr} ${doc['en'.tr]['name']}',
              style: TextStyle(
                  fontSize: Responsive.isTablet(context) ? 17.0 : 15.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 7.0,
            ),
            Wrap(
              children: [
                SizedBox(
                  child: GridView.count(
                    shrinkWrap: true,
                    // primary: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 20 / 9,
                    crossAxisCount: (Responsive.isTablet(context)) ? 5 : 4,
                    children: doc['en'.tr]['nutrients'].map<Widget>(
                      (label) {
                        return GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                context.read<ChatGPTBloc>().add(
                                      GetResult(
                                          message:
                                              '${'Definition and benefits of consuming foods that contain'.tr} $label'),
                                    );
                                return AlertDialog(
                                  insetPadding: const EdgeInsets.all(8.0),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.close)),
                                      Text(
                                        label,
                                        style: TextStyle(
                                            fontSize:
                                                (Responsive.isTablet(context))
                                                    ? 35.0
                                                    : 20.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 50.0,
                                      ),
                                    ],
                                  ),
                                  content:
                                      BlocBuilder<ChatGPTBloc, ChatGPTState>(
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
                                                TyperAnimatedText(
                                                  state.result,
                                                  textStyle: TextStyle(
                                                      fontSize:
                                                          (Responsive.isTablet(
                                                                  context))
                                                              ? 30.0
                                                              : 15.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(
                                          width: size.width * 0.8,
                                          height: size.height * 0.7,
                                          child: const SpinKitThreeBounce(
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(1.0, 3.0, 1.0, 2.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(3.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 2.0),
                                  child: Center(
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              (Responsive.isTablet(context))
                                                  ? 22.0
                                                  : 11.0),
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10.0,
                ),
                itemCount: doc['en'.tr]['nutrients-info'].length,
                itemBuilder: (context, index) {
                  return Text(
                    doc['en'.tr]['nutrients-info'][index],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: (Responsive.isTablet(context)) ? 22.0 : 13.0,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
