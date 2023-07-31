import 'package:flutter/material.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../responsive.dart';

class CameraScreenHeader extends StatelessWidget {
  const CameraScreenHeader({super.key, required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Center(
        child: Text(
          l10n.scanFruitVegetable,
          style: TextStyle(
            fontFamily: 'GT Maru',
            color: Colors.white,
            fontSize: Responsive.isTablet(context) ? 21 : 12,
          ),
        ),
      ),
    );
  }
}
