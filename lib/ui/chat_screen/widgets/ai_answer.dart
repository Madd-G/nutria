// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
//
// class AiAnswer extends StatelessWidget {
//   final String msg;
//   final bool shouldAnimate;
//
//   const AiAnswer({
//     Key? key,
//     required this.msg,
//     required this.shouldAnimate,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 height: 20.0,
//                 width: 20.0,
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(25.0)),
//                 child: const Center(
//                     child: Text(
//                   'N',
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.w700),
//                 )),
//               ),
//               const SizedBox(
//                 width: 10.0,
//               ),
//               const Text(
//                 'NutriAI',
//                 style: TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 30.0,
//               ),
//               shouldAnimate
//                   ? Expanded(
//                       child: DefaultTextStyle(
//                         style: const TextStyle(
//                             color: Colors.black,
//                             // fontWeight: FontWeight.w700,
//                             fontSize: 12.0),
//                         child: AnimatedTextKit(
//                           isRepeatingAnimation: false,
//                           repeatForever: false,
//                           displayFullTextOnTap: true,
//                           totalRepeatCount: 1,
//                           animatedTexts: [
//                             TyperAnimatedText(
//                               msg.trim(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : Expanded(
//                       child: Text(
//                         msg.trim(),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             // fontWeight: FontWeight.w700,
//                             fontSize: 16),
//                       ),
//                     ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
