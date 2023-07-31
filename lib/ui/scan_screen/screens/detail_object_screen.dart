import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../blocs/blocs.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/widgets.dart';
import 'dart:io';

class DetailObjectScreen extends StatefulWidget {
  const DetailObjectScreen({super.key, this.image, this.url});

  final File? image;
  final String? url;

  @override
  State<DetailObjectScreen> createState() => _DetailObjectScreenState();
}

class _DetailObjectScreenState extends State<DetailObjectScreen> {

  @override
  void initState() {
    context.read<PredictionBloc>().add(
          GetPrediction(
            imagePath: widget.image!.path,
            baseUrl: widget.url!,
          ),
        );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

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
              predictionModel: predictionState.prediction!,
              imagePath: widget.image!.path,
              l10n: l10n,
            ),
          );
        } else if (predictionState is PredictionErrorState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.errorOccurred,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        l10n.back,
                        style: const TextStyle(color: Colors.white),
                      ))
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
