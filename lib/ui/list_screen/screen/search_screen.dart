import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../chat_screen/screen/chat_screen.dart';
import '../widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String searched;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.addListener(_updateText);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _updateText() {
    setState(() {
      searched = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      mainScreenWidget: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Search',
            style: TextStyle(
              fontFamily: 'GT Maru',
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.search),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          counterText: "",
                          hintText: "Enter the word you want to search",
                        ),
                      ),
                    ),
                    const Icon(Icons.cancel),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('items')
                    .where("name", isEqualTo: searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Not Found"));
                  }
                  if (snapshot.hasData) {
                    final DocumentSnapshot doc = snapshot.data!.docs[0];
                    return ProductCard(doc: doc);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
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
