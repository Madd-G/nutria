import 'package:flutter/material.dart';
import 'package:nutria/blocs/bloc_imports.dart';
import '../../../utils/dialogs/logout_dialog.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AuthBloc>();

    return GestureDetector(
      onTap: () async {
        final shouldLogOut = await showLogOutDialog(context);
        if (shouldLogOut) {
          appBloc.add(
            const AuthEventLogOut(),
          );
        }
      },
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
            'Log Out',
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
