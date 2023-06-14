import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../models/models.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<AddHistory>((event, emit) {
      createHistory(event.predResult);
      // List<Prediction> historyResult = createHistory(event.predResult);
      // emit(HistorySuccessState(historyModel: historyResult));
    });

    on<GetAllHistoryEvent>((event, emit) {
      getAllHistDoc();
    });

    on<GetHistoryEvent>((event, emit) {
      getHist();
      // emit(HistorySuccessState(historyModel: historyResult));
    });
  }

  getAllHistDoc() async {
    final user = FirebaseAuth.instance.currentUser;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('history')
        .get();
    final userData = snapshot.docs.map((e) => PredictionModel.fromSnapshot(e)).toList();
    return userData;
  }

  getHist() async {
    final user = FirebaseAuth.instance.currentUser;

    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user?.uid)
    //       .collection('history')
    //       .get().then((value) {
    //   print("++++++ ${value.docs[0].get('objects')}");
    //       print("a.docs[0].get(objects) ${value.docs[0].get('objects').runtimeType}");
    //   String histsStr = jsonEncode(value.docs[0].get('objects')).toString();
    //   List<Prediction> hists = modelFromJson(histsStr);
    //   return hists;
    // }
    //   );

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('history')
        .get();
    final userData = snapshot.docs.map((e) => Prediction.fromSnapshot(e)).toList();
    return userData;
  }

  createHistory(List<Prediction> predictions) async {
    List<Map<String, dynamic>> convertedList = [];
    for (Prediction prediction in predictions) {
      Map<String, dynamic> convertedMap = {
        'classLabel': prediction.classLabel,
        'className': prediction.className,
        'confidence': prediction.confidence,
        // 'bbox' : prediction.bbox,
      };
      convertedList.add(convertedMap);
    }

    List<Map<String, dynamic>> objects = convertedList;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final myUuid = const Uuid().v4();
    try {
      // subcollection
      // final DocumentReference documentRef = firestore.collection('users').doc(user!.uid);
      // final CollectionReference subCollectionRef = documentRef.collection('objects $myUuid');
      // for (final object in objects) {
      //   await subCollectionRef.add(object);
      // }

      // array
      await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('history')
          .doc()
          .set({
        'objects': objects,
      });
      // .then((value) => print("Special of the day has been written"))
      // .catchError((error) => print('You got an error! $error'));
    } catch (e) {
      rethrow;
    }
    // }
  }
}
