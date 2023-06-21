import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:nutria/models/models.dart';
import '../../services/services.dart';

part 'prediction_event.dart';

part 'prediction_state.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  PredictionBloc() : super(PredictionInitial()) {
    ApiService apiService = ApiService();

    on<GetPrediction>((event, emit) async {
      Future<List<Prediction>> getPrediction(String imgPath) async {
        try {
          List<Prediction> prediction = await apiService.uploadImage(imgPath);
          return prediction;
        } on DioException catch (_) {
          rethrow;
        }
      }

      try {
        emit(PredictionLoadingState());
        List<Prediction> result = await getPrediction(event.imagePath);
        emit(PredictionSuccessState(prediction: result));
      } catch (e) {
        emit(PredictionErrorState(e, e.toString()));
      }
    });
  }
}
