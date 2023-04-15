import 'package:flutter/material.dart';

class ScanBanner extends StatelessWidget {
  const ScanBanner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
