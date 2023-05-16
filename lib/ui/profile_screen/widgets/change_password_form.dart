import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
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

    return Expanded(
      child: Form(
        key: _updatePasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Old Password',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
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
                      borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                  hintText: 'Enter old password',
                  hintStyle: const TextStyle(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
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
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
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
                      borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                  hintText: 'Enter new password',
                  hintStyle: const TextStyle(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
            ),
            SizedBox(
              height: size.height * 0.018,
            ),
            const Text(
              'Confirm New Password',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
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
                          _showHideNewPassConfirm = !_showHideNewPassConfirm;
                        },
                      )
                    },
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF7F7F7),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                  hintText: 'Confirm new password',
                  hintStyle: const TextStyle(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
            ),
            SizedBox(
              height: size.height * 0.018,
            ),
          ],
        ),
      ),
    );
  }
}
