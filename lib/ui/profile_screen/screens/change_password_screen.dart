import 'package:flutter/material.dart';
import 'package:nutria/blocs/bloc_imports.dart';
import '../widgets/widgets.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenBloc = context.read<ScreenBloc>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            screenBloc.add(ScreenEventGoToProfileScreen());
          },
        ),
        title: const Text('Change Password'),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ChangePasswordForm(),
            ChangePasswordSaveButton(),
          ],
        ),
      ),
    );
  }
}

