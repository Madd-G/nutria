import 'package:flutter/material.dart';

class UserDataForm extends StatefulWidget {
  const UserDataForm({Key? key}) : super(key: key);

  @override
  State<UserDataForm> createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _updateFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF7F7F7),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xFFE9EBEF))),
                        hintText: 'Alamsyah',
                        hintStyle: TextStyle(),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xFFE9EBEF))),
                        contentPadding: EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF7F7F7),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFFE9EBEF))),
                          hintText: 'akhmadnuralamsyah@gmail.com',
                          hintStyle: TextStyle(),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFFE9EBEF))),
                          contentPadding: EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)))),
                      validator: (String? value) {
                        const String expression = "[a-zA-Z0-9+._%-+]{1,256}"
                            "\\@"
                            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
                            "("
                            "\\."
                            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
                            ")+";
                        final RegExp regExp = RegExp(expression);
                        return !regExp.hasMatch(value!)
                            ? "Silakan, masukkan email yang valid!"
                            : null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
