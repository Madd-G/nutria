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
        print('PredictionSuccessState');
          context.read<HistoryBloc>().add(AddHistory(predResult: predictionState.prediction!));
          return DefaultTabController(
            length: (predictionState.prediction!.isEmpty)
                ? 1
                : predictionState.prediction!.length,
            child: PredictionSuccessView(
              size: size,
              predictionSuccess: predictionState,
              predictionModel: predictionState.prediction!,
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
