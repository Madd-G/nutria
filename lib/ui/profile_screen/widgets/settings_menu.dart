import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../../utils/dialogs/dialogs.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    final screenBloc = context.read<ScreenBloc>();
    final authBloc = context.read<AuthBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 25.0),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 5.0,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: Image.asset(
                    'assets/images/user-edit.png',
                    color: Colors.grey,
                  ),
                ),
                title: const Text(
                  'User Data',
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  screenBloc.add(ScreenEventGoToUserDataScreen());
                },
              ),
              const Divider(
                height: 5,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(
                  Icons.password,
                  size: 30.0,
                ),
                title: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  screenBloc.add(ScreenEventGoToChangePasswordScreen());
                },
              ),
              const Divider(
                height: 5,
                thickness: 1,
              ),
              // const ListTile(
              //   leading: Icon(
              //     Icons.language,
              //     size: 30.0,
              //   ),
              //   title: Text(
              //     'Language',
              //     style: TextStyle(fontSize: 20.0),
              //   ),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              const Divider(
                height: 5,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(
                  Icons.dark_mode_outlined,
                  size: 30.0,
                ),
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: CupertinoSwitch(
                    value: light,
                    onChanged: (value) {
                      setState(() {
                        light = value;
                      });
                    }),
              ),
              const Divider(
                height: 5,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  size: 30.0,
                ),
                title: const Text(
                  'History',
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  screenBloc.add(ScreenEventGoToHistoryDetailScreen());
                },
              ),
              const Divider(
                height: 5,
                thickness: 1,
              ),
              ListTile(
                onTap: () async {
                  final shouldDeleteAccount =
                      await showDeleteAccountDialog(context);
                  if (shouldDeleteAccount) {
                    authBloc.add(
                      const AuthEventDeleteAccount(),
                    );
                  }
                },
                leading: const Icon(
                  Icons.delete_forever,
                  size: 30.0,
                ),
                title: const Text(
                  'Delete Account',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
