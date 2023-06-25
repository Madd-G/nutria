import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';

class DetailObjectScreen extends StatelessWidget {
  const DetailObjectScreen({super.key, this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, predictionState) {
        if (predictionState is PredictionLoadingState) {
          return Scaffold(
            body: Center(
              child: Lottie.asset(
                'assets/animation/scanning.json',
              ),
            ),
          );
        } else if (predictionState is PredictionSuccessState) {
          return DefaultTabController(
            length: (predictionState.prediction!.isEmpty)
                ? 1
                : predictionState.prediction!.length,
            child: PredictionSuccessView(
              predictionSuccess: predictionState,
              predictionModel: predictionState.prediction!,
              imagePath: imagePath,
            ),
          );
        } else if (predictionState is PredictionErrorState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Oops, an error occurred'),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('BACK'))
                ],
              ),
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
