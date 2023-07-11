import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../responsive.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(8.0),
              title: const Text('Logout'),
              content: SizedBox(
                width: 300.0,
                height: 80.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await googleSignIn.signOut();
                        await FirebaseAuth.instance.signOut().then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Berhasil logout'),
                                ),
                              ),
                            );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                          child: Row(
                            children: [
                              Text(
                                '  YA  ',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                          child: Row(
                            children: [
                              Text(
                                'TIDAK',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        width: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        child: Center(
          child: Text(
            // FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
            FirebaseAuth.instance.currentUser!.email![0].toUpperCase(),
            style: TextStyle(
                fontSize: (Responsive.isTablet(context)) ? 60 : 30.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:nutria/ui/home_screen/widgets/register_dialog.dart';
// import '../../../blocs/blocs.dart';
// import '../../../responsive.dart';
// import '../../chat_screen/screen/chat_screen.dart';
//
// class LoginDialog extends StatefulWidget {
//   const LoginDialog({
//     super.key,
//   });
//
//   @override
//   State<LoginDialog> createState() => _LoginDialogState();
// }
//
// class _LoginDialogState extends State<LoginDialog> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _emailRegisterController =
//       TextEditingController();
//   final TextEditingController _passwordRegisterController =
//       TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//
//   bool checkBox = false;
//   late bool _showLoginPassword;
//   late bool _showRegisterPassword;
//   late bool _showConfirmPassword;
//
//   @override
//   void initState() {
//     _showLoginPassword = true;
//     _showRegisterPassword = true;
//     _showConfirmPassword = true;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _emailRegisterController.dispose();
//     _passwordRegisterController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               insetPadding: const EdgeInsets.all(8.0),
//               content: SizedBox(
//                 width: 330.0,
//                 height: 600.0,
//                 child: BlocBuilder<AuthCubit, AuthState>(
//                   builder: (blocContext, state) {
//                     // ############################################################
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         SizedBox(
//                           height: size.height * 0.020,
//                         ),
//                         const Center(
//                             child: Text(
//                           'Selamat Datang',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 23.0),
//                         )),
//                         const Center(
//                             child: Text('Silakan masuk dengan akun anda',
//                                 style: TextStyle(fontSize: 15.0))),
//                         SizedBox(
//                           height: size.height * 0.018,
//                         ),
//                         Form(
//                             key: formKey,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 const Text(
//                                   'Email',
//                                   style: TextStyle(
//                                       fontSize: 15.0,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.01,
//                                 ),
//                                 TextFormField(
//                                   controller: _emailController,
//                                   decoration: const InputDecoration(
//                                       filled: true,
//                                       fillColor: Color(0xFFF7F7F7),
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Color(0xFFF6F6F6))),
//                                       hintText: 'Masukkan email anda',
//                                       hintStyle: TextStyle(),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: Color(0xFFF6F6F6))),
//                                       contentPadding: EdgeInsets.all(12.0),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(8)))),
//                                   validator: (String? value) {
//                                     const String expression =
//                                         "[a-zA-Z0-9+._%-+]{1,256}"
//                                         "\\@"
//                                         "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
//                                         "("
//                                         "\\."
//                                         "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
//                                         ")+";
//                                     final RegExp regExp = RegExp(expression);
//                                     return !regExp.hasMatch(value!)
//                                         ? "Silakan, masukkan email yang valid!"
//                                         : null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.018,
//                                 ),
//                                 const Text(
//                                   'Password',
//                                   style: TextStyle(
//                                       fontSize: 15.0,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.01,
//                                 ),
//                                 StatefulBuilder(builder: (context, setState) {
//                                   return TextFormField(
//                                     controller: _passwordController,
//                                     obscureText: _showLoginPassword,
//                                     obscuringCharacter: '◉',
//                                     decoration: InputDecoration(
//                                         suffixIcon: IconButton(
//                                           icon: _showLoginPassword
//                                               ? const Icon(Icons.visibility_off)
//                                               : const Icon(Icons.visibility),
//                                           onPressed: () => {
//                                             setState(
//                                               () {
//                                                 _showLoginPassword =
//                                                     !_showLoginPassword;
//                                               },
//                                             )
//                                           },
//                                         ),
//                                         filled: true,
//                                         fillColor: const Color(0xFFF7F7F7),
//                                         focusedBorder: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Color(0xFFF6F6F6))),
//                                         hintText: 'Masukkan password anda',
//                                         hintStyle: const TextStyle(),
//                                         enabledBorder: const OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Color(0xFFE9EBEF))),
//                                         contentPadding:
//                                             const EdgeInsets.all(12.0),
//                                         border: const OutlineInputBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(8)))),
//                                     validator: (String? value) {
//                                       if (value!.isEmpty) {
//                                         return 'Silakan isi kolom kata sandi!';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   );
//                                 }),
//                                 SizedBox(
//                                   height: size.height * 0.018,
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.018,
//                                 ),
//                                 ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         padding: const EdgeInsets.all(12.0),
//                                         backgroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .primary,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8))),
//                                     onPressed: () {
//                                       String email =
//                                           _emailController.text.trim();
//                                       String password =
//                                           _passwordController.text.trim();
//                                       if (formKey.currentState!.validate()) {
//                                         context
//                                             .read<AuthCubit>()
//                                             .signInWithEmail(email, password)
//                                             //     .then(
//                                             //       (value) =>
//                                             //           ScaffoldMessenger.of(context)
//                                             //               .showSnackBar(
//                                             //         const SnackBar(
//                                             //           content: Text('Berhasil Login'),
//                                             //         ),
//                                             //       ),
//                                             //     );
//                                             .then((value) => FirebaseAuth
//                                                     .instance
//                                                     .authStateChanges()
//                                                     .listen((User? user) {
//                                                   if (user == null) {
//                                                     print(
//                                                         'User is currently signed out!');
//                                                     // setState(() {});
//                                                   } else {
//                                                     print('go to chat');
//                                                     // setState(() {});
//                                                     ScaffoldMessenger.of(
//                                                             context)
//                                                         .showSnackBar(
//                                                       const SnackBar(
//                                                         content: Text(
//                                                             'Berhasil Login'),
//                                                       ),
//                                                     );
//                                                   }
//                                                 }));
//                                         Navigator.pop(context);
//                                       }
//                                     },
//                                     child: const Text('MASUK')),
//                                 SizedBox(
//                                   height: size.height * 0.020,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Container(
//                                       height: size.height * 0.001,
//                                       width: size.width * 0.3,
//                                       color: const Color(0xFFA9A9A9),
//                                     ),
//                                     const Text(
//                                       'atau',
//                                       style: TextStyle(
//                                           fontSize: 15.0,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     Container(
//                                       height: size.height * 0.001,
//                                       width: size.width * 0.3,
//                                       color: const Color(0xFFA9A9A9),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: size.height * 0.03,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         context
//                                             .read<AuthCubit>()
//                                             .signInWithApple(context)
//                                             .then(
//                                               (value) =>
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(
//                                                 const SnackBar(
//                                                   content:
//                                                       Text('Berhasil Login'),
//                                                 ),
//                                               ),
//                                             );
//                                         Navigator.pop(context);
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5.0),
//                                           border:
//                                               Border.all(color: Colors.grey),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Image.asset(
//                                             'assets/images/apple-logo.png',
//                                             width: 30.0,
//                                             height: 30.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 15.0,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () async {
//                                         context
//                                             .read<AuthCubit>()
//                                             .signInWithGoogle(context)
//                                             .then(
//                                               (value) =>
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(
//                                                 const SnackBar(
//                                                   content:
//                                                       Text('Berhasil Login'),
//                                                 ),
//                                               ),
//                                             );
//                                         // (mounted) {
//                                         Navigator.pop(blocContext);
//                                         // };
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5.0),
//                                           border:
//                                               Border.all(color: Colors.grey),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Image.asset(
//                                             'assets/images/google.png',
//                                             width: 30.0,
//                                             height: 30.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             )),
//                         SizedBox(
//                           height: size.height * 0.02,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Belum punya akun?',
//                               style: TextStyle(),
//                             ),
//                             const SizedBox(
//                               width: 5.0,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 print('Go to register');
//                                 context
//                                     .read<AuthCubit>()
//                                     .goToRegistrationView();
//                               },
//                               child: Text(
//                                 'Daftar',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color:
//                                         Theme.of(context).colorScheme.primary),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//       child: Container(
//         height: (Responsive.isTablet(context)) ? 65.0 : 45.0,
//         width: (Responsive.isTablet(context)) ? 65.0 : 45.0,
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(100.0),
//           ),
//         ),
//         child: Icon(
//           Icons.account_circle,
//           size: (Responsive.isTablet(context)) ? 65 : 45.0,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
