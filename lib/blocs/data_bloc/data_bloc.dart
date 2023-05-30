import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nutria/models/models.dart';

import '../../services/services.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    final ApiService service = ApiService();

    on<GetRecommendations>((event, emit) async {
      try {
        emit(LoadingState());
        final DataModel result = await service.fetchRecommendations();
        emit(RecommendationsSuccessState(result));
      } catch (e) {
        emit(ErrorState(e, e.toString()));
      }
    });

    on<GetFruits>((event, emit) async {
      try {
        emit(LoadingState());
        final DataModel result = await service.fetchFruits();
        emit(FruitsSuccessState(result));
      } catch (e) {
        emit(ErrorState(e, e.toString()));
      }
    });

    on<GetVegetables>((event, emit) async {
      try {
        emit(LoadingState());
        final DataModel result = await service.fetchVegetables();
        emit(VegetablesSuccessState(result));
      } catch (e) {
        emit(ErrorState(e, e.toString()));
      }
    });
  }
}
