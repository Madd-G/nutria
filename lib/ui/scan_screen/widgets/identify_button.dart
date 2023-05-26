import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';

class IdentifyButton extends StatelessWidget {
  const IdentifyButton({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
            onPressed: () {
              context
                  .read<PredictionBloc>()
                  .add(GetPrediction(imagePath: imagePath));
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return BlocBuilder<PredictionBloc, PredictionState>(
                      builder: (context, state) {
                    if (state is PredictionLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PredictionSuccessState) {
                      return Center(
                        child: Text((double.parse(
                                    state.predictionModel.confidence) <
                                0.5)
                            ? 'No fruit or vegetables detected'
                            : '${state.predictionModel.className}, confidence: ${double.parse(state.predictionModel.confidence).toStringAsFixed(2)}%'),
                      );
                    } else if (state is PredictionErrorState) {
                      return const Center(child: Text('An error occurred'));
                      // child: Text('An error occurred'));
                    } else {
                      return const SizedBox();
                    }
                  });
                },
              );
            },
            child: const Text('IDENTIFY')),
      ),
    );
  }
}
