// import 'package:flutter/material.dart';
// import '../../../blocs/blocs.dart';
//
// class LoginDialog extends StatelessWidget {
//   const LoginDialog({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 insetPadding: const EdgeInsets.all(8.0),
//                 title: const Text('Login'),
//                 content: SizedBox(
//                   width: 300.0,
//                   height: 80.0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           context
//                               .read<AuthCubit>()
//                               .signInWithGoogle(context)
//                               .then(
//                                 (value) =>
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Berhasil Login'),
//                                   ),
//                                 ),
//                           );
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5.0),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Padding(
//                             padding:
//                             const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
//                             child: Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/images/google.png',
//                                   width: 30.0,
//                                   height: 30.0,
//                                 ),
//                                 const SizedBox(width: 10.0),
//                                 const Text(
//                                   'Google',
//                                   style: TextStyle(fontWeight: FontWeight.w700),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5.0),
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: Padding(
//                           padding:
//                           const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 'assets/images/apple-logo.png',
//                                 width: 30.0,
//                                 height: 30.0,
//                               ),
//                               const SizedBox(width: 10.0),
//                               const Text(
//                                 'Apple',
//                                 style: TextStyle(fontWeight: FontWeight.w700),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//
//       ),
//     );
//   }
// }
