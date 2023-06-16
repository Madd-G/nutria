// import 'package:draggable_fab/draggable_fab.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../blocs/blocs.dart';
// import '../ui/chat_screen/screen/chat_screen.dart';
//
// class NutriAIButton extends StatelessWidget {
//   const NutriAIButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableFab(
//       child: FloatingActionButton(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         onPressed: () {
//           if (FirebaseAuth.instance.currentUser?.uid == null) {
//             context.read<AuthCubit>().signInWithGoogle(context);
//           } else {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const ChatScreen()));
//           }
//         },
//       ),
//     );
//   }
// }
