import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';

class DetailObjectScreen extends StatelessWidget {
  const DetailObjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, predictionState) {
        if (predictionState is PredictionLoadingState) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (predictionState is PredictionSuccessState) {
          context
              .read<HistoryBloc>()
              .add(AddHistory(predResult: predictionState.predictionModel!));

          return DefaultTabController(
            length: (predictionState.predictionModel!.isEmpty)
                ? 1
                : predictionState.predictionModel!.length,
            child: PredictionSuccessView(
              size: size,
              predictionSuccess: predictionState,
              predictionModel: predictionState.predictionModel!,
            ),
          );
        } else if (predictionState is PredictionErrorState) {
          return Scaffold(
              body: Center(child: Text(predictionState.errorMessage)));
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
