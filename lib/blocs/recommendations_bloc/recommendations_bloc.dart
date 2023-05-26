import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nutria/models/models.dart';
import '../../services/services.dart';

part 'recommendations_event.dart';

part 'recommendations_state.dart';

class RecommendationsBloc
    extends Bloc<RecommendationsEvent, RecommendationsState> {
  RecommendationsBloc() : super(RecommendationsLoadingState()) {
    final ApiService service = ApiService();
    on<GetRecommendations>(
      (event, emit) async {
        try {
          emit(RecommendationsLoadingState());
          final RecommendationsModel result =
              await service.fetchRecommendations();
          emit(RecommendationsSuccessState(result));
        } catch (e) {
          emit(RecommendationsErrorState(e, e.toString()));
        }
      },
    );
  }
}
