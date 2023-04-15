import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Find fruits or vegetables',
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                ),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
