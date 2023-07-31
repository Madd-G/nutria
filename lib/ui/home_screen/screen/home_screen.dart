import 'package:flutter/material.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../../../widgets/global_widgets.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return NutriAIButton(
      screenHeight: MediaQuery.of(context).size.height * 0.95,
      mainWidget: LayoutBuilder(
        builder: (context, BoxConstraints constraint) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    WelcomeSection(
                      size: size,
                      l10n: l10n,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ScanBanner(l10n: l10n),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CategorySection(l10n: l10n),
                        ],
                      ),
                    ),
                    RecommendationSection(l10n: l10n),
                    // const RecommendationSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
