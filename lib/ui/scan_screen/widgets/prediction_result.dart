import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import 'package:nutria/models/models.dart';

class PredictionResult extends StatelessWidget {
  const PredictionResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, state) {
        if (state is PredictionLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PredictionSuccessState) {
          return Results(successState: state);
        } else if (state is PredictionErrorState) {
          return const Center(child: Text('An error occurred'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class Results extends StatelessWidget {
  const Results({Key? key, required this.successState}) : super(key: key);

  final PredictionSuccessState successState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Column(
            children: [
              const Text('Object Detected'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Object'),
                  Text('Confidence'),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: successState.predictionModel.length,
                  itemBuilder: (context, index) {
                    PredictionModel object =
                        successState.predictionModel[index];
                    return ListTile(
                      title: BlocProvider.value(
                        value: BlocProvider.of<ScreenBloc>(context),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<ScreenBloc>()
                                .add(ScreenEventGoToHomeScreen());
                          },
                          child: Text(
                            object.className,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                      trailing: Text(
                          '${double.parse(object.confidence).toStringAsFixed(1)}%'),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
