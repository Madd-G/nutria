import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.doc,
  });

  final DocumentSnapshot<Object?> doc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: const Image(
              height: 250.0,
              width: 250.0,
              image: AssetImage('assets/images/fruit.png'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 5.0,
            bottom: 15.0,
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                child: Text(
                  '${doc['name']}',
                  style: const TextStyle(
                    color: Colors.black26,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
