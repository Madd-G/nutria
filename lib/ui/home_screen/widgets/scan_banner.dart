import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';

class ScanBanner extends StatelessWidget {
  const ScanBanner({super.key, required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(13.0),
      child: GestureDetector(
        onTap: () {
          context.read<BottomNavBarBloc>().add(EventGoToScanScreen());
        },
        child: Container(
          height: size.height * 0.10,
          width: double.infinity,
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/scan.png'),
                const SizedBox(
                  width: 18.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            l10n.scanNow,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              // color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            l10n.fruitVegetableUpper,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              // color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
