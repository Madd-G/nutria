import 'package:flutter/material.dart';
import '../../../widgets/nutriai_button.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NutriAIButton(
      screenHeight: MediaQuery.of(context).size.height * 0.95,
      mainWidget: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  WelcomeSection(size: size),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const ScanBanner(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        const CategorySection(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                  const RecommendationSection(),
                ],
              ),
              const SearchBox(),
            ],
          ),
        ),
      ),
    );
  }
}
