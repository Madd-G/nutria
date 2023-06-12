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
      Future<List<PredictionModel>> getPrediction(String imgPath) async {
        try {
          List<PredictionModel> prediction =
              await apiService.uploadImage(imgPath);
          return prediction;
        } on DioError catch (_) {
          rethrow;
        }
      }

      try {
        emit(PredictionLoadingState());
        List<PredictionModel> result = await getPrediction(event.imagePath);
        emit(PredictionSuccessState(predictionModel: result));
      } catch (e) {
        emit(PredictionErrorState(e, e.toString()));
      }
    });
  }
}
