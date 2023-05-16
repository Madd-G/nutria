import 'package:flutter/material.dart';
import 'package:nutria/blocs/bloc_imports.dart';
import '../widgets/widgets.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({Key? key}) : super(key: key);

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
        title: const Text('User Data'),
        elevation: 0.0,
      ),
      body: Column(
        children: const [
          UserDataHeader(),
          UserDataForm(),
          UserDataSaveButton(),
        ],
      ),
    );
  }
}



