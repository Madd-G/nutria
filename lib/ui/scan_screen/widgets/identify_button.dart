import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/ui/scan_screen/screens/detail_object_screen.dart';

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
                  .add(GetPrediction(imagePath: imagePath,));
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailObjectScreen(imagePath: imagePath)));
            },
            child: const Text('IDENTIFY')),
      ),
    );
  }
}
