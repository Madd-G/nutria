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
      mainWidget: LayoutBuilder(builder: (context, BoxConstraints constraint) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  WelcomeSection(size: size),
                  SizedBox(
                    height: size.height * 0.01,
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
                      ],
                    ),
                  ),
                  const RecommendationSection(),
                  // const RecommendationSection(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
