import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _updatePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmController =
      TextEditingController();
  bool _showHideOldPass = true;
  bool _showHideNewPass = true;
  bool _showHideNewPassConfirm = true;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Form(
                        key: _updatePasswordFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Old Password',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.018,
                            ),
                            TextFormField(
                              controller: oldPasswordController,
                              obscureText: _showHideOldPass,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: _showHideOldPass
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () => {
                                      setState(
                                        () {
                                          _showHideOldPass = !_showHideOldPass;
                                        },
                                      )
                                    },
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF7F7F7),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  hintText: 'Enter old password',
                                  hintStyle: const TextStyle(),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                              // validator: (String? value) {
                              //   if (value!.isEmpty) {
                              //     return '';
                              //   } else {
                              //     return null;
                              //   }
                              // }
                            ),
                            SizedBox(
                              height: size.height * 0.018,
                            ),
                            const Text(
                              'New Password',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.018,
                            ),
                            TextFormField(
                              controller: newPasswordController,
                              obscureText: _showHideNewPass,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: _showHideNewPass
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () => {
                                      setState(
                                        () {
                                          _showHideNewPass = !_showHideNewPass;
                                        },
                                      )
                                    },
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF7F7F7),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  hintText: 'Enter new password',
                                  hintStyle: const TextStyle(),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                            ),
                            SizedBox(
                              height: size.height * 0.018,
                            ),
                            const Text(
                              'Confirm New Password',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.018,
                            ),
                            TextFormField(
                              controller: newPasswordConfirmController,
                              obscureText: _showHideNewPassConfirm,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: _showHideNewPassConfirm
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () => {
                                      setState(
                                        () {
                                          _showHideNewPassConfirm =
                                              !_showHideNewPassConfirm;
                                        },
                                      )
                                    },
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF7F7F7),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  hintText: 'Confirm new password',
                                  hintStyle: const TextStyle(),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE9EBEF))),
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                            ),
                            SizedBox(
                              height: size.height * 0.018,
                            ),
                          ],
                        )),
                  ),
                  GestureDetector(
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
