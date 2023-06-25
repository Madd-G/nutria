import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../screens.dart';
import '../widgets/widgets.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key, required this.doc}) : super(key: key);

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingDraggableWidget(
      mainScreenWidget: Scaffold(
        body: Stack(
          children: [
            ArticleImage(size: size, doc: doc),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SizedBox(
                  height: size.height * 0.76,
                  width: size.width,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          ArticleTitle(doc: doc),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ArticleHeader(doc: doc),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Article(doc: doc)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
        ),
      ),
      floatingWidgetWidth: 55,
      floatingWidgetHeight: 55,
    );
  }
}
