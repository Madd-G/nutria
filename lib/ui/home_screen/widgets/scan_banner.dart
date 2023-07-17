import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutria/ui/scan_screen/screens/scan_screen.dart';

class ScanBanner extends StatelessWidget {
  const ScanBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(13.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScanScreen(),
            ),
          );
        },
        child: Container(
          height: size.height * 0.10,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'SCAN NOW TO DETECT'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              // color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'FRUITS AND VEGETABLES'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              // color: Colors.white,
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
    );
  }
}
