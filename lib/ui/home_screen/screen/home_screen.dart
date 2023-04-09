import 'package:flutter/material.dart';

import '../widgets/category_box.dart';
import '../widgets/recommendation_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: 220,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.055,
                        ),
                        const Text(
                          'Hello alamsyah',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        const Text(
                          'Let\'s Learn More About\nFruits and Vegetables',
                          style: TextStyle(
                            letterSpacing: 2.5,
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: size.height * 0.11,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              'SCAN TO LEARN ABOUT',
                                              style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              'FRUITS AND VEGETABLES',
                                              style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
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
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Category',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          CategoryBox(
                            imagePath: 'assets/images/fruit.png',
                            route: '/fruit_list_screen',
                            label: 'Fruit',
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          CategoryBox(
                            imagePath: 'assets/images/vegetable.png',
                            route: '/vegetable_list_screen',
                            label: 'Vegetable',
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Recommendations',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'See All',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const RecommendationCarousel()
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 180,
              left: size.width / 14,
              right: size.width / 14,
              // right: width/2,
              // left: -175,
              child: Container(
                height: 70.0,
                // width: 320.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 1.0,
                          blurStyle: BlurStyle.outer,
                          offset: Offset.fromDirection(1.0),
                          spreadRadius: 1.0)
                    ],
                    borderRadius: BorderRadius.circular(30.0)),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Find fruits or vegetables',
                        hintStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
