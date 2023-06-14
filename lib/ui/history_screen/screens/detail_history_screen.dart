import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../../models/prediction_model.dart';
import 'history_success_screen.dart';

class DetailHistoryScreen extends StatelessWidget {
  const DetailHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    // return BlocBuilder<HistoryBloc, HistoryState>(
    //   builder: (context, historyState) {
    //     if (historyState is HistorySuccessState) {
    //       return const Scaffold(
    //           body: Center(child: CircularProgressIndicator()));
    //     } else if (historyState is HistorySuccessState) {
    //       // context.read<HistoryBloc>().add(AddHistory(predResult: historyState!));
    //       return DefaultTabController(
    //         length: (historyState.historyModel.isEmpty)
    //             ? 1
    //             : historyState.historyModel.length,
    //         child: HistorySuccessScreen(
    //           size: size,
    //           historySuccess: historyState,
    //           historyModel: historyState.historyModel,
    //         ),
    //       );
    //     } else {
    //       return const Scaffold();
    //     }
    //   },
    // );
    return FutureBuilder(
        future: getHist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print('Alhamdulillah');
              // Prediction userData = snapshot.data as Prediction;
              return Scaffold(
                body: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red, height: 10.0, width: 100,
                        ),
                      ),
                      Text(snapshot.data![index].className),
                      Text(snapshot.data![index].confidence),
                    ],
                  );
                })
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                  body: Center(
                child: Text('${snapshot.error}'),
              ));
            } else {
              return const Scaffold(body: Text('Else'));
            }
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Future<List<Prediction>> getHist() async {
    final user = FirebaseAuth.instance.currentUser;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('history')
        .get();
    List<Prediction> userData = snapshot.docs.map((e) => Prediction.fromSnapshot(e)).toList();
    print('<<<<userData $userData');
    return userData;
  }
}
