import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:nutria/models/models.dart';
import '../../../blocs/blocs.dart';
import '../../chat_screen/screen/chat_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, this.data}) : super(key: key);
  final Data? data;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Detail Screen'),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       size: 30.0,
      //     ),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      body: FloatingDraggableWidget(
        mainScreenWidget: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.3,
                  width: double.infinity,
                  child: const Hero(
                    tag: 'hero',
                    child: Image(
                      image: AssetImage("assets/images/fruit.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data!.name!,
                        style: const TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      const Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * 0.003,
                      ),
                      Text(
                        data!.category!,
                        style: const TextStyle(fontSize: 17.0),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      const Text(
                        'Nutrition and mineral',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * 0.003,
                      ),
                      Text(
                        data!.nutrients!,
                        style: const TextStyle(fontSize: 17.0),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        data!.description!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 17.0,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      const Text(
                        'Benefits',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * 0.003,
                      ),
                      Text(
                        data!.benefits!,
                        style: const TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
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
