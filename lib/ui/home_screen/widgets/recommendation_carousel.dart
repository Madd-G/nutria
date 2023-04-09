import 'package:flutter/material.dart';

class RecommendationCarousel extends StatelessWidget {
  const RecommendationCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
          reverse: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Image(
                          height: 250.0,
                          width: 250.0,
                          image: AssetImage('assets/images/fruit.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5.0,
                      bottom: 15.0,
                      child: Stack(
                        children: [
                          Container(
                            width: 70,
                            height: 25,
                            // color: Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(5, 3, 0, 0),
                            child: Text(
                              'Fruit',
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
