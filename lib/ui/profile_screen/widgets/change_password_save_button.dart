import 'package:flutter/material.dart';

class ChangePasswordSaveButton extends StatelessWidget {
  const ChangePasswordSaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
