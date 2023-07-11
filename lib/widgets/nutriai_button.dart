import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../blocs/blocs.dart';
import '../ui/chat_screen/screen/chat_screen.dart';

class NutriAIButton extends StatefulWidget {
  const NutriAIButton({super.key, required this.mainWidget, this.screenHeight});

  final Widget mainWidget;
  final double? screenHeight;

  @override
  State<NutriAIButton> createState() => _NutriAIButtonState();
}

class _NutriAIButtonState extends State<NutriAIButton> {
  final GlobalKey<FormState> nutriaiFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool checkBox = false;
  late bool _showLoginPassword;

  @override
  void initState() {
    _showLoginPassword = true;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingDraggableWidget(
      mainScreenWidget: widget.mainWidget,
      screenHeight: widget.screenHeight,
      floatingWidget: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return FloatingActionButton(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              tooltip: 'Hello, may I help you?',
              onPressed: () {
                if (FirebaseAuth.instance.currentUser?.uid == null) {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        insetPadding: const EdgeInsets.all(8.0),
                        content: SizedBox(
                          width: 330.0,
                          height: 600.0,
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              if (state is AuthStateIsInRegistrationView) {
                                return RegisterDialog(
                                  dialogContext: dialogContext,
                                );
                              } else {
                                // login
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 23.0),
                                        )),
                                    const Center(
                                        child: Text('Silakan masuk dengan akun anda',
                                            style: TextStyle(fontSize: 15.0))),
                                    SizedBox(
                                      height: size.height * 0.018,
                                    ),
                                    Form(
                                        key: nutriaiFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const Text(
                                              'Email',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            TextFormField(
                                              controller: _emailController,
                                              decoration: const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xFFF7F7F7),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(0xFFF6F6F6))),
                                                  hintText: 'Masukkan email anda',
                                                  hintStyle: TextStyle(),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(0xFFF6F6F6))),
                                                  contentPadding: EdgeInsets.all(12.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(8)))),
                                              validator: (String? value) {
                                                const String expression =
                                                    "[a-zA-Z0-9+._%-+]{1,256}"
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
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            StatefulBuilder(builder: (context, setState) {
                                              return TextFormField(
                                                controller: _passwordController,
                                                obscureText: _showLoginPassword,
                                                obscuringCharacter: '◉',
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                      icon: _showLoginPassword
                                                          ? const Icon(
                                                          Icons.visibility_off)
                                                          : const Icon(Icons.visibility),
                                                      onPressed: () => {
                                                        setState(
                                                              () {
                                                            _showLoginPassword =
                                                            !_showLoginPassword;
                                                          },
                                                        )
                                                      },
                                                    ),
                                                    filled: true,
                                                    fillColor: const Color(0xFFF7F7F7),
                                                    focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                            Color(0xFFF6F6F6))),
                                                    hintText: 'Masukkan password anda',
                                                    hintStyle: const TextStyle(),
                                                    enabledBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                            Color(0xFFE9EBEF))),
                                                    contentPadding:
                                                    const EdgeInsets.all(12.0),
                                                    border: const OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(8)))),
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
                                            SizedBox(
                                              height: size.height * 0.018,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets.all(12.0),
                                                    backgroundColor: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(8))),
                                                onPressed: () {
                                                  String email =
                                                  _emailController.text.trim();
                                                  String password =
                                                  _passwordController.text.trim();
                                                  if (nutriaiFormKey.currentState!.validate()) {
                                                    context
                                                        .read<AuthCubit>()
                                                        .signInWithEmail(email, password)
                                                    //     .then(
                                                    //       (value) =>
                                                    //           ScaffoldMessenger.of(context)
                                                    //               .showSnackBar(
                                                    //         const SnackBar(
                                                    //           content: Text('Berhasil Login'),
                                                    //         ),
                                                    //       ),
                                                    //     );
                                                        .then((value) => FirebaseAuth
                                                        .instance
                                                        .authStateChanges()
                                                        .listen((User? user) {
                                                      if (user == null) {
                                                        print(
                                                            'User is currently signed out!');
                                                        setState(() {});
                                                      } else {
                                                        print('go to chat');
                                                        setState(() {});
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'Berhasil Login'),
                                                          ),
                                                        );
                                                      }
                                                    }));
                                                    Navigator.pop(dialogContext);
                                                  }
                                                },
                                                child: const Text('MASUK')),
                                            SizedBox(
                                              height: size.height * 0.020,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: size.height * 0.001,
                                                  width: size.width * 0.3,
                                                  color: const Color(0xFFA9A9A9),
                                                ),
                                                const Text(
                                                  'atau',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w400),
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
                                                    context
                                                        .read<AuthCubit>()
                                                        .signInWithApple(context)
                                                        .then(
                                                          (value) => ScaffoldMessenger.of(
                                                          context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content:
                                                          Text('Berhasil Login'),
                                                        ),
                                                      ),
                                                    );
                                                    Navigator.pop(dialogContext);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5.0),
                                                      border:
                                                      Border.all(color: Colors.grey),
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
                                                    context
                                                        .read<AuthCubit>()
                                                        .signInWithGoogle(context)
                                                        .then(
                                                          (value) => ScaffoldMessenger.of(
                                                          context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content:
                                                          Text('Berhasil Login'),
                                                        ),
                                                      ),
                                                    );
                                                    // (mounted) {
                                                    Navigator.pop(dialogContext);
                                                    // };
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5.0),
                                                      border:
                                                      Border.all(color: Colors.grey),
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
                                        )),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Belum punya akun?',
                                          style: TextStyle(),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print('Go to register');
                                            context
                                                .read<AuthCubit>()
                                                .goToRegistrationView();
                                          },
                                          child: Text(
                                            'Daftar',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/AI.png',
                ),
              ),
            );
          }),
      floatingWidgetWidth: 55,
      floatingWidgetHeight: 55,
    );
  }
}
