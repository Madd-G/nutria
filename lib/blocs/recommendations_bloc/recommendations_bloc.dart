import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nutria/models/recommendations_model.dart';
import '../../services/services.dart';

part 'recommendations_event.dart';

part 'recommendations_state.dart';

class RecommendationsBloc
    extends Bloc<RecommendationsEvent, RecommendationsState> {
  RecommendationsBloc() : super(LoadingState()) {
    final ApiService service = ApiService();
    on<RecommendationsEvent>(
      (event, emit) async {
        try {
          emit(LoadingState());
          final RecommendationsModel result =
              await service.fetchRecommendations();
          emit(SuccessState(result));
        } catch (e) {
          emit(ErrorState(e, e.toString()));
        }
      },
    );
  }
}
