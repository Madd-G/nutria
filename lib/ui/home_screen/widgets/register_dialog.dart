import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({
    super.key,
    required this.dialogContext,
  });

  final BuildContext dialogContext;

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailRegisterController =
      TextEditingController();
  final TextEditingController _passwordRegisterController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late bool _showRegisterPassword;
  late bool _showConfirmPassword;

  @override
  void initState() {
    _showRegisterPassword = true;
    _showConfirmPassword = true;
    super.initState();
  }

  @override
  void dispose() {
    _emailRegisterController.dispose();
    _passwordRegisterController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: size.height * 0.020,
        ),
        const Center(
            child: Text(
          'Selamat Datang',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
        )),
        const Center(
            child: Text('Silakan membuat akun baru',
                style: TextStyle(fontSize: 15.0))),
        SizedBox(
          height: size.height * 0.018,
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Email',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                controller: _emailRegisterController,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF7F7F7),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF6F6F6))),
                    hintText: 'Masukkan email anda',
                    hintStyle: TextStyle(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF6F6F6))),
                    contentPadding: EdgeInsets.all(12.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
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
              SizedBox(
                height: size.height * 0.018,
              ),
              const Text(
                'Password',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              StatefulBuilder(builder: (context, setState) {
                return TextFormField(
                  controller: _passwordRegisterController,
                  obscureText: _showRegisterPassword,
                  obscuringCharacter: '◉',
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _showRegisterPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () => {
                          setState(
                            () {
                              _showRegisterPassword = !_showRegisterPassword;
                            },
                          )
                        },
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF6F6F6))),
                      hintText: 'Masukkan password anda',
                      hintStyle: const TextStyle(),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                      contentPadding: const EdgeInsets.all(12.0),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Silakan isi kolom kata sandi!';
                    } else {
                      return null;
                    }
                  },
                );
              }),
              SizedBox(
                height: size.height * 0.018,
              ),
              const Text(
                'Konfirmasi Password',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              StatefulBuilder(builder: (context, setState) {
                return TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _showConfirmPassword,
                  obscuringCharacter: '◉',
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _showConfirmPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () => {
                          setState(
                            () {
                              _showConfirmPassword = !_showConfirmPassword;
                            },
                          )
                        },
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF6F6F6))),
                      hintText: 'Konfirmasi password anda',
                      hintStyle: const TextStyle(),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE9EBEF))),
                      contentPadding: const EdgeInsets.all(12.0),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Silakan isi kolom konfirmasi kata sandi!';
                    } else if (_passwordRegisterController.text !=
                        _confirmPasswordController.text) {
                      return 'Konfirmasi password tidak sama';
                    } else {
                      return null;
                    }
                  },
                );
              }),
              SizedBox(
                height: size.height * 0.018,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12.0),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    String email = _emailRegisterController.text.trim();
                    String password = _passwordRegisterController.text.trim();
                    String confirmPassword =
                        _confirmPasswordController.text.trim();
                    if (formKey.currentState!.validate()) {
                      context
                          .read<AuthCubit>()
                          .registerWithEmail(email, password)
                          //     .then(
                          //       (value) =>
                          //           ScaffoldMessenger.of(context)
                          //               .showSnackBar(
                          //         const SnackBar(
                          //           content: Text('Berhasil Login'),
                          //         ),
                          //       ),
                          //     );
                          .then((value) => FirebaseAuth.instance
                                  .authStateChanges()
                                  .listen((User? user) {
                                if (user == null) {
                                  print('User is currently signed out!');
                                  setState(() {});
                                } else {
                                  print('go to chat');
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Berhasil Login'),
                                    ),
                                  );
                                }
                              }));
                      Navigator.pop(widget.dialogContext);
                    }
                  },
                  child: const Text('DAFTAR')),
              SizedBox(
                height: size.height * 0.020,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: size.height * 0.001,
                    width: size.width * 0.3,
                    color: const Color(0xFFA9A9A9),
                  ),
                  const Text(
                    'atau',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: size.height * 0.001,
                    width: size.width * 0.3,
                    color: const Color(0xFFA9A9A9),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<AuthCubit>().signInWithApple(context).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Berhasil Login'),
                              ),
                            ),
                          );
                      Navigator.pop(widget.dialogContext);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/apple-logo.png',
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthCubit>().signInWithGoogle(context).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Berhasil Login'),
                              ),
                            ),
                          );
                      // (mounted) {
                      Navigator.pop(widget.dialogContext);
                      // };
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/google.png',
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sudah punya akun?',
              style: TextStyle(),
            ),
            const SizedBox(
              width: 5.0,
            ),
            GestureDetector(
              onTap: () {
                context.read<AuthCubit>().goToLoginView();
              },
              child: Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
      ],
    );
  }
}
