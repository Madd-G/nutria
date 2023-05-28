import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:nutria/blocs/blocs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        context.read<DataBloc>().add(GetRecommendations());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      ScanBanner(size: size),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CategorySection(size: size),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const RecommendationSection(),
                    ],
                  ),
                )
              ],
            ),
            SearchBox(size: size),
          ],
        ),
      ),
    );
  }
}
