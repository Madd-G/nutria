import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/dialogs/network_alert.dart';
import '../widgets/widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is NetworkFailure) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showNetworkAlert(
                context: context,
                title: l10n.noInternetTitle,
                content: l10n.cannotScan,
                onPressed: () {
                  context.read<BottomNavBarBloc>().add(EventGoToHomeScreen());
                  Navigator.pop(context);
                },
              );
            });
            return Column(
              children: [
                Flexible(flex: 1, child: CameraScreenHeader(l10n: l10n)),
                Expanded(flex: 9, child: CameraContent(l10n: l10n)),
              ],
            );
          } else {
            return Column(
              children: [
                Flexible(flex: 1, child: CameraScreenHeader(l10n: l10n)),
                Expanded(flex: 9, child: CameraContent(l10n: l10n)),
              ],
            );
          }
        },
      ),
    );
  }
}
