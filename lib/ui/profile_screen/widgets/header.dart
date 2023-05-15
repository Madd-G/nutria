import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile-3.png'),
          radius: 35.0,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Alamsyah',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'akhmadnuralamsyah@gmail.com',
              style: TextStyle(fontSize: 16.0),
            )
          ],
        )
      ],
    );
  }
}
