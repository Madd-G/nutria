import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/prediction_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Screen'),
      ),
      body: FutureBuilder(
          future: getAllHistDoc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print('ConnectionState.done');
              if (snapshot.hasData) {
                print('Alhamdulillah');

                // PredictionModel userData = snapshot as PredictionModel;

                return Scaffold(
                  body: Container(),
                  // body: ListView.builder(
                  //     itemCount: userData.data!.length,
                  //     itemBuilder: (context, index) {
                  //       return Text('${userData.data!.length}');
                  //     }),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                    body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${snapshot.data?.length}'),
                      Text('${snapshot.data}'),
                    ],
                  ),
                ));
              } else if (!snapshot.hasData) {
                return const Scaffold(
                    body: Center(
                  child: Text('There is no data'),
                ));
              } else {
                return const Scaffold(body: Text('Else'));
              }
            }
            else {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }

  Future<List<PredictionModel>> getAllHistDoc() async {
    final user = FirebaseAuth.instance.currentUser;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('history')
        .get();
    print('getting userData');
    print('snapshot : ${snapshot.docs}');
    // PredictionModel.fromJson(snapshot.docs);
    List<PredictionModel> userData = snapshot.docs.map((e) => PredictionModel.fromJson(e)).toList();
    print('<<<<<<< userData $userData');
    return userData;
  }
}
