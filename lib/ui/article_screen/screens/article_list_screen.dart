import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../chat_screen/screen/chat_screen.dart';
import '../widgets/widgets.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingDraggableWidget(
      mainScreenWidget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.18),
            child: Column(
              children: const [
                SafeArea(
                  child: Center(
                    child: Text(
                      'Articles',
                      style: TextStyle(
                        fontFamily: 'GT Maru',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SearchBar(),
              ],
            ),
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('article').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const SizedBox(
                child: Center(child: Text("Not found")),
              );
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ArticleList(
                size: size,
                docs: documents,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      // screenHeight: MediaQuery.of(context).size.height * 0.95,
      floatingWidget: FloatingActionButton(
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
          )),
      floatingWidgetWidth: 55,
      floatingWidgetHeight: 55,
    );
  }
}
