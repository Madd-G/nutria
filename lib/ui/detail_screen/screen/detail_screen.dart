import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../blocs/blocs.dart';
import '../../screens.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 10.0,
      ),
      body: FloatingDraggableWidget(
        mainScreenWidget: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.3,
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
                          doc['name'],
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
                                doc['category'],
                                style: const TextStyle(),
                                softWrap: false,
                                textAlign: TextAlign.center,
                              )),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Text(
                      'Daftar informasi gizi umum untuk ${doc['name']} (per 100 gram)',
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    StaggeredGrid.count(
                      crossAxisCount: 3,
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
                                        message:
                                            'Pengertian dan manfaat $label'));
                                    return AlertDialog(
                                      title: Text(label),
                                      content: BlocBuilder<ChatGPTBloc,
                                          ChatGPTState>(
                                        builder: (context, state) {
                                          if (state is ChatGPTIsSuccess) {
                                            return AnimatedTextKit(
                                              isRepeatingAnimation: true,
                                              repeatForever: false,
                                              displayFullTextOnTap: true,
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                TyperAnimatedText(
                                                  state.result,
                                                ),
                                              ],
                                            );
                                          } else {
                                            return const SpinKitThreeBounce(
                                              color: Colors.black,
                                              size: 18,
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
                      doc['description'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 17.0,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Text(
                      'Manfaat ${doc['name']}',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: height * 0.003,
                    ),
                    Text(
                      doc['benefits'],
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ],
                )
              ],
            ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen()));
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
      ),
    );
  }
}
