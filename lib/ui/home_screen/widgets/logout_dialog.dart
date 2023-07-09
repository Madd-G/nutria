// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../../../responsive.dart';
//
// class LogoutDialog extends StatelessWidget {
//   const LogoutDialog({
//     super.key,
//     required this.googleSignIn,
//   });
//
//   final GoogleSignIn googleSignIn;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               insetPadding: const EdgeInsets.all(8.0),
//               title: const Text('Logout'),
//               content: SizedBox(
//                 width: 300.0,
//                 height: 80.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         await googleSignIn.signOut();
//                         await FirebaseAuth.instance.signOut();
//                         (mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Berhasil logout')),
//                           );
//                         };
//                         (mounted) {
//                           Navigator.pop(context);
//                         };
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5.0),
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
//                           child: Row(
//                             children: [
//                               Text(
//                                 '  YA  ',
//                                 style: TextStyle(fontWeight: FontWeight.w700),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         (mounted) {
//                           Navigator.pop(context);
//                         };
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5.0),
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'TIDAK',
//                                 style: TextStyle(fontWeight: FontWeight.w700),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//       child: Center(
//         child: Text(
//           FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
//           style: TextStyle(
//               fontSize: (Responsive.isTablet(context)) ? 65 : 30.0,
//               color: Colors.white,
//               fontWeight: FontWeight.w700),
//         ),
//       ),
//     );
//   }
// }
