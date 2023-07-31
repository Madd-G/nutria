import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';

class NutrientInfo extends StatefulWidget {
  const NutrientInfo({
    super.key,
    required this.doc,
    required this.l10n,
  });

  final DocumentSnapshot doc;
  final AppLocalizations l10n;

  @override
  State<NutrientInfo> createState() => _NutrientInfoState();
}

class _NutrientInfoState extends State<NutrientInfo> {
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
              '${widget.l10n.generalInformation} ${widget.doc[widget.l10n.lang]['name']}',
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 12.0 : 20.0,
                  fontWeight: FontWeight.w500),
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
                    crossAxisCount: (Responsive.isMobile(context)) ? 4 : 5,
                    children:
                        widget.doc[widget.l10n.lang]['nutrients'].map<Widget>(
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
                                                (Responsive.isMobile(context))
                                                    ? 20.0
                                                    : 35.0,
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
                                                          (Responsive.isMobile(
                                                                  context))
                                                              ? 15.0
                                                              : 30.0),
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
                                        fontSize: (Responsive.isMobile(context))
                                            ? 10.0
                                            : 22.0),
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
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
                itemCount:
                    widget.doc[widget.l10n.lang]['nutrients-info'].length,
                itemBuilder: (context, index) {
                  return Text(
                    widget.doc[widget.l10n.lang]['nutrients-info'][index],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: (Responsive.isMobile(context)) ? 11.0 : 22.0,
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
