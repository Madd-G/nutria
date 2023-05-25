import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';

class CameraScreenHeader extends StatelessWidget {
  const CameraScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () =>
                  context.read<ScreenBloc>().add(ScreenEventGoToHomeScreen()),
              iconSize: 24.0,
              icon: const Icon(Icons.close, color: Colors.white)),
          const Text(
            "Scan your thing",
            style: TextStyle(
              fontFamily: 'GT Maru',
              color: Colors.white,
              fontSize: 21,
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
