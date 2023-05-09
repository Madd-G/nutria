import 'package:flutter/material.dart';
import 'package:nutria/blocs/bloc_imports.dart';
import '../../../utils/dialogs/logout_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AuthBloc>();

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            final shouldLogOut = await showLogOutDialog(context);
            if (shouldLogOut) {
              appBloc.add(
                const AuthEventLogOut(),
              );
            }
          },
          child: const Text('Profile Screen'),
        ),
      ),
    );
  }
}
