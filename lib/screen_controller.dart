import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutria/responsive.dart';
import 'blocs/blocs.dart';
import 'l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'ui/screens.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: (state is StateIsInScanScreen)
              ? const ScanScreen()
              : (state is StateIsInArticleScreen)
                  ? const ArticleListScreen()
                  : const HomeScreen(),
          bottomNavigationBar: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  gap: 8,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: Responsive.isMobile(context) ? 9.0 : 12.0),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Theme.of(context).colorScheme.primary,
                  selectedIndex: state.index,
                  onTabChange: (index) {
                    if (index == 0) {
                      context
                          .read<BottomNavBarBloc>()
                          .add(EventGoToHomeScreen());
                    } else if (index == 1) {
                      context
                          .read<BottomNavBarBloc>()
                          .add(EventGoToScanScreen());
                    } else if (index == 2) {
                      context
                          .read<BottomNavBarBloc>()
                          .add(EventGoToArticleScreen());
                    }
                  },
                  tabs: [
                    GButton(
                      key: const Key('home_tab'),
                      icon: Icons.home,
                      iconSize: Responsive.isMobile(context) ? 25.0 : 30.0,
                      text: l10n.home,
                    ),
                    GButton(
                      icon: Ionicons.scan_sharp,
                      iconSize: Responsive.isMobile(context) ? 25.0 : 30.0,
                      text: l10n.scan,
                    ),
                    GButton(
                      key: const Key('article_tab'),
                      icon: Icons.article,
                      iconSize: Responsive.isMobile(context) ? 25.0 : 30.0,
                      text: l10n.article,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
