import 'package:flutter/material.dart';

class UserDataSaveButton extends StatelessWidget {
  const UserDataSaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 30.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}