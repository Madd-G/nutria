import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  const UserInput(
      {Key? key,
      required this.label,
      this.fontSize = 14,
      this.color,
      this.fontWeight})
      : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0)),
              child: const Center(
                  child: Text(
                'M',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              'Madd',
              style: TextStyle(fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 30.0,
            ),
            Expanded(
              child: Text(
                label,
                // textAlign: TextAlign.justify,
                style: TextStyle(
                  color: color ?? Colors.black,
                  fontSize: fontSize,
                  // fontWeight: fontWeight ?? FontWeight.w500,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
