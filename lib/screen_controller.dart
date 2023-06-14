import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'ui/screens.dart';
import 'blocs/blocs.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ScreenBloc, ScreenState>(
        builder: (_, screenState) {
          if (screenState is ScreenStateIsInScreenController) {
            return const HomeScreen();
          } else if (screenState is ScreenStateIsInScanScreen) {
            return const ScanScreen();
          } else if (screenState is ScreenStateIsInArticleScreen) {
            return const ArticleScreen();
          } else if (screenState is ScreenStateIsInHomeScreen) {
            return const HomeScreen();
          } else if (screenState is ScreenStateIsInLoginScreen) {
            return const LoginScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Screen Controller builder error'),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: BlocBuilder<ScreenBloc, ScreenState>(
              builder: (context, state) {
                return GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Theme.of(context).colorScheme.primary,
                  color: Colors.black,
                  tabs: const [
                    GButton(
                      icon: Icons.camera_alt,
                      text: 'SCAN',
                    ),
                    GButton(
                      icon: Icons.home,
                      text: 'HOME',
                    ),
                    GButton(
                      icon: Icons.article,
                      text: 'Article',
                    ),
                  ],
                  selectedIndex: (state is ScreenStateIsInScanScreen)
                      ? 0
                      : (state is ScreenStateIsInArticleScreen)
                          ? 2
                          : 1,
                  onTabChange: (index) {
                    if (index == 0) {
                      context
                          .read<ScreenBloc>()
                          .add(ScreenEventGoToScanScreen());
                    } else if (index == 1) {
                      context
                          .read<ScreenBloc>()
                          .add(ScreenEventGoToHomeScreen());
                    } else if (index == 2) {
                      context
                          .read<ScreenBloc>()
                          .add(ScreenEventGoToArticleScreen());
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
