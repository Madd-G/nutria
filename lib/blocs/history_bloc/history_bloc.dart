import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../models/models.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<AddHistory>((event, emit) {
      createHistory(event.predResult);
    });
  }

  createHistory(List<PredictionModel> predictionModel) {
    final user = FirebaseAuth.instance.currentUser;
    final myUuid = const Uuid().v4();
    for (PredictionModel object in predictionModel) {
      try {
        DocumentReference docUser =
            FirebaseFirestore.instance.collection('users').doc(user!.uid);
        final subDoc = docUser.collection('history');
        final subSubDoc = subDoc.doc(subDoc.id).collection('hist $myUuid');
        History history = History(
          id: docUser.id,
          className: object.className,
          confidence: object.confidence,
          timestamp: FieldValue.serverTimestamp(),
        );
        Map<String, dynamic> json = history.toJson();
        subSubDoc.add(json);
      } catch (e) {
        rethrow;
      }
    }
  }
}
