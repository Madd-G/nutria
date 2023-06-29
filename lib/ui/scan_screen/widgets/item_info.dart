import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../blocs/blocs.dart';

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
                  doc['name'],
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.w900),
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
                      doc['category'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            const Text(
              'Nutrition and mineral',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: doc['nutrients'].map<Widget>(
                (label) {
                  return GestureDetector(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            context.read<ChatGPTBloc>().add(GetResult(
                                message: 'Pengertian dan manfaat mengkonsumsi $label'));
                            return AlertDialog(
                              insetPadding: const EdgeInsets.all(8.0),
                              title: Text(label),
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
                                            TyperAnimatedText(state.result),
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
                          });
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
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11.0),
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
            const Text(
              'Description',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 3.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 15.0,
              ),
              itemCount: doc['general-info'].length,
              itemBuilder: (context, index) {
                return Text(
                  doc['general-info'][index],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            const Text(
              'Benefits',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 15.0,
              ),
              itemCount: doc['benefits'].length,
              itemBuilder: (context, index) {
                return Text(
                  doc['benefits'][index],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 13.0,
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
