import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nutria/widgets/nutriai_button.dart';
import '../../../blocs/blocs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('items')
        .doc(widget.doc.id)
        .update({'viewed': widget.doc['viewed'] + 1});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 10.0,
      ),
      body: NutriAIButton(
        mainWidget: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.3,
                  width: double.infinity,
                  child: const Hero(
                    tag: 'hero',
                    child: Image(
                      image: AssetImage("assets/images/apples.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.doc['name'],
                          style: const TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 12.0),
                              child: Center(
                                  child: Text(
                                widget.doc['category'],
                                style: const TextStyle(),
                                softWrap: false,
                                textAlign: TextAlign.center,
                              )),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Text(
                      'Daftar informasi gizi umum untuk ${widget.doc['name']} (per 100 gram)',
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      children: widget.doc['nutrients'].map<Widget>(
                        (label) {
                          return GestureDetector(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    context.read<ChatGPTBloc>().add(GetResult(
                                        message:
                                            'Pengertian dan manfaat $label'));
                                    return AlertDialog(
                                      insetPadding: const EdgeInsets.all(8.0),
                                      title: Text(label),
                                      content: BlocBuilder<ChatGPTBloc,
                                          ChatGPTState>(
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
                                                        state.result),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 2.0),
                                  child: Center(
                                      child: Text(
                                    label,
                                    style: const TextStyle(),
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                  )),
                                )),
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      widget.doc['description'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 17.0,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Text(
                      'Manfaat ${widget.doc['name']}',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.003,
                    ),
                    Text(
                      widget.doc['benefits'],
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
