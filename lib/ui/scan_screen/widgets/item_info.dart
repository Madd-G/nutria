import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';

class ItemInfo extends StatefulWidget {
  const ItemInfo({
    super.key,
    required this.doc,
    required this.l10n,
  });

  final DocumentSnapshot doc;
  final AppLocalizations l10n;

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  String apiKey = '';

  @override
  void initState() {
    fetchApiKey();
    super.initState();
  }

  Future<String> fetchApiKey() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('url')
          .doc('A1LwZfXMxWAh34RJQuu0')
          .get();

      if (snapshot.exists) {
        setState(() {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          apiKey = data['api-key'];
        });
      } else {
        setState(() {
          apiKey = 'Value not found';
        });
      }
      return apiKey;
    } catch (e) {
      setState(() {
        // Error occurred while fetching data.
        apiKey = 'Error: $e';
      });
      rethrow;
    }
  }

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
                  widget.doc[widget.l10n.lang]['name'],
                  style: TextStyle(
                      fontSize: (Responsive.isMobile(context)) ? 20.0 : 40.0,
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
                      widget.doc[widget.l10n.lang]['category'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: (Responsive.isMobile(context)) ? 15.0 : 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.isMobile(context)
                  ? size.height * 0.008
                  : size.height * 0.02,
            ),
            Text(
              widget.l10n.nutrientsAndMinerals,
              style: TextStyle(
                  fontSize: (Responsive.isMobile(context)) ? 11.0 : 30.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 2.5,
              children: widget.doc[widget.l10n.lang]['nutrients'].map<Widget>(
                (label) {
                  return GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          context.read<ChatGPTBloc>().add(
                                GetResult(
                                    message:
                                        '${widget.l10n.definitionAndBenefits} $label',
                                    apiKey: apiKey),
                              );
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
                                      fontSize: (Responsive.isMobile(context))
                                          ? 15.0
                                          : 35.0,
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
                                                      (Responsive.isMobile(
                                                              context))
                                                          ? 12.0
                                                          : 30.0)),
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
                                      size: (Responsive.isMobile(context))
                                          ? 18.0
                                          : 25.0,
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
                              vertical: 8.0, horizontal: 1.0),
                          child: Center(
                              child: Text(
                            label,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: (Responsive.isMobile(context))
                                    ? 11.0
                                    : 25.0),
                            softWrap: false,
                            textAlign: TextAlign.center,
                          )),
                        )),
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: Responsive.isMobile(context)
                  ? size.height * 0.018
                  : size.height * 0.025,
            ),
            Text(
              widget.l10n.description,
              style: TextStyle(
                  fontSize: (Responsive.isMobile(context)) ? 13.0 : 30.0,
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
              itemCount: widget.doc[widget.l10n.lang]['general-info'].length,
              itemBuilder: (context, index) {
                return Text(
                  widget.doc[widget.l10n.lang]['general-info'][index],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (Responsive.isMobile(context)) ? 11.0 : 22.0,
                  ),
                );
              },
            ),
            SizedBox(
              height: Responsive.isMobile(context)
                  ? size.height * 0.015
                  : size.height * 0.025,
            ),
            Text(
              '${widget.l10n.benefitsConsuming} ${widget.doc[widget.l10n.lang]['name']}',
              style: TextStyle(
                  fontSize: (Responsive.isMobile(context)) ? 13.0 : 30.0,
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
              itemCount: widget.doc[widget.l10n.lang]['benefits'].length,
              itemBuilder: (context, index) {
                return Text(
                  widget.doc[widget.l10n.lang]['benefits'][index],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: (Responsive.isMobile(context)) ? 11.0 : 22.0,
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
