import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/main_button.dart';

class SplashScreenSecond extends StatelessWidget {
  const SplashScreenSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 450,
                    width: 350,
                    child: Image.asset('assets/images/splash2_image.png'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                      'Find Out The Nutrition and Benefits of\nFruits and Vegetables'
                          .tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Color(0xffDBDBDB), shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MainButton(
                    title: "Next".tr,
                    onPressed: () {
                      Get.toNamed('/login_screen');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
