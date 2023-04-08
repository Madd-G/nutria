import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nutria/blocs/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:nutria/ui/home_screen/screen/home_screen.dart';
import 'package:nutria/ui/profile_screen/screen/profile_screen.dart';
import 'package:nutria/ui/scan_screen/screen/scan_screen.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavBarBloc, ScreenState>(
          builder: (_, state) => (state is ScanState)
              ? const ScanScreen()
              : (state is ProfileState)
                  ? const ProfileScreen()
                  : const HomeScreen()),
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
            child: BlocBuilder<BottomNavBarBloc, ScreenState>(
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
                      icon: Icons.person,
                      text: 'PROFILE',
                    ),
                  ],
                  selectedIndex: state.index,
                  onTabChange: (index) {
                    if (index == 0) {
                      context.read<BottomNavBarBloc>().add(ScanEvent());
                    } else if (index == 1) {
                      context.read<BottomNavBarBloc>().add(HomeEvent());
                    } else if (index == 2) {
                      context.read<BottomNavBarBloc>().add(ProfileEvent());
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
