import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'blocs/blocs.dart';
import 'ui/screens.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: (state is StateIsInScanScreen)
              ? const ScanScreen()
              : (state is StateIsInArticleScreen)
                  ? const ArticleListScreen()
                  : const HomeScreen(),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
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
                // rippleColor: Colors.grey[300]!,
                // hoverColor: Colors.grey[100]!,
                gap: 8,
                // activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.primary,
                // color: Colors.black,
                selectedIndex: state.index,
                onTabChange: (index) {
                  if (index == 0) {
                    context
                        .read<BottomNavBarBloc>()
                        .add(EventGoToScanScreen());
                  } else if (index == 1) {
                    context
                        .read<BottomNavBarBloc>()
                        .add(EventGoToHomeScreen());
                  } else if (index == 2) {
                    context
                        .read<BottomNavBarBloc>()
                        .add(EventGoToArticleScreen());
                  }
                },
                tabs: [
                  GButton(
                    icon: Icons.camera_alt,
                    text: 'SCAN'.tr,
                  ),
                  GButton(
                    icon: Icons.home,
                    text: 'HOME'.tr,
                  ),
                  GButton(
                    icon: Icons.article,
                    text: 'ARTICLE'.tr,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
