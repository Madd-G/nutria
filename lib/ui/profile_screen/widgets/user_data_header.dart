import 'package:flutter/material.dart';

class UserDataHeader extends StatelessWidget {
  const UserDataHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 190.0,
          width: double.infinity,
          color: Theme.of(context).colorScheme.primary,
        ),
        Column(
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile-3.png'),
              radius: 60.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'akhmadnuralamsyah@gmail.com',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            )
          ],
        ),
      ],
    );
  }
}
