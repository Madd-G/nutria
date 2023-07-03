import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'dart:io';


class DetailObjectScreen extends StatefulWidget {
  const DetailObjectScreen({super.key, this.image});

  final File? image;

  @override
  State<DetailObjectScreen> createState() => _DetailObjectScreenState();
}

class _DetailObjectScreenState extends State<DetailObjectScreen> {
  @override
  void initState() {
    context.read<PredictionBloc>().add(GetPrediction(
      imagePath: widget.image!.path,
    ));
    super.initState();
  }
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
              imagePath: widget.image!.path,
            ),
          );
        } else if (predictionState is PredictionErrorState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Text('Oops, an error occurred'),
                  Text(predictionState.errorMessage),
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
