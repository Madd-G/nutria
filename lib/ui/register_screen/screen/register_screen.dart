// import 'package:flutter/material.dart';
// import 'package:nutria/blocs/blocs.dart';
// import 'package:nutria/utils/extensions/extensions.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final emailController = TextEditingController(
//     text: 'alam@gmail.com'.ifDebugging,
//   );
//
//   final passwordController = TextEditingController(
//     text: 'alam123'.ifDebugging,
//   );
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Register',
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your email here...',
//               ),
//               keyboardType: TextInputType.emailAddress,
//               keyboardAppearance: Brightness.dark,
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your password here...',
//               ),
//               keyboardAppearance: Brightness.dark,
//               obscureText: true,
//               obscuringCharacter: '◉',
//             ),
//             TextButton(
//               onPressed: () {
//                 final email = emailController.text.trim();
//                 final password = passwordController.text.trim();
//                 context.read<AuthBloc>().add(
//                       AuthEventRegister(
//                         email: email,
//                         password: password,
//                       ),
//                     );
//               },
//               child: const Text(
//                 'Register',
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 context.read<ScreenBloc>().add(ScreenEventGoToLoginScreen());
//               },
//               child: const Text(
//                 'Already registered? Log in here!',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
