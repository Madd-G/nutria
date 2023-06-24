import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../screens.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key, required this.doc}) : super(key: key);

  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingDraggableWidget(
      mainScreenWidget: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: Image.network(
                            doc['profile-image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        '  ${doc['author']}  •  ${doc['date']}  •  ${doc['category']}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    doc['title'],
                    style: const TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: SizedBox(
                      height: 250.0,
                      width: size.width,
                      child: Image.network(
                        doc['item-image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Center(
                      child: Text('${doc['picture-description']}',
                          style: const TextStyle(color: Colors.grey))),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    doc['article'],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
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
