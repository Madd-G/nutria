// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import '../../../provider/chat_provider.dart';
// import '../widgets/chat_widget.dart';
// import '../widgets/user_input.dart';
//
// class ChatScreenOld extends StatefulWidget {
//   const ChatScreenOld({super.key});
//
//   @override
//   State<ChatScreenOld> createState() => _ChatScreenOldState();
// }
//
// class _ChatScreenOldState extends State<ChatScreenOld> {
//   bool _isTyping = false;
//   bool isAutoScroll = true;
//   late TextEditingController textEditingController;
//   late ScrollController _listScrollController;
//   late FocusNode focusNode;
//
//   @override
//   void initState() {
//     _listScrollController = ScrollController();
//     textEditingController = TextEditingController();
//     focusNode = FocusNode();
//
//     super.initState();
//   }
//
//   // _scrollToBottom() {
//   //   _listScrollController
//   //       .jumpTo(_listScrollController.position.maxScrollExtent);
//   // }
//
//   @override
//   void dispose() {
//     _listScrollController.dispose();
//     textEditingController.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final chatProvider = Provider.of<ChatProvider>(context);
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Flexible(
//               child: GestureDetector(
//                 onTap: () => isAutoScroll = false,
//                 child: ListView.builder(
//                     controller: _listScrollController,
//                     itemCount: chatProvider.getChatList.length,
//                     //chatList.length,
//                     itemBuilder: (context, index) {
//                       // if (isAutoScroll == true) {
//                       //   Timer.periodic(const Duration(milliseconds: 100),
//                       //       (timer) {
//                       //     if (mounted) {
//                       //       _scrollToBottom();
//                       //     } else {
//                       //       timer.cancel();
//                       //     }
//                       //   });
//                       // }
//                       return ChatWidget(
//                         isAutoScroll: isAutoScroll,
//                         msg: chatProvider.getChatList[index].msg,
//                         // chatList[index].msg,
//                         chatIndex: chatProvider.getChatList[index].chatIndex,
//                         //chatList[index].chatIndex,
//                         shouldAnimate:
//                             chatProvider.getChatList.length - 1 == index,
//                       );
//                     }),
//               ),
//             ),
//             if (_isTyping) ...[
//               const SpinKitThreeBounce(
//                 color: Colors.black,
//                 size: 18,
//               ),
//             ],
//             const SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           keyboardType: TextInputType.multiline,
//                           showCursor: true,
//                           cursorColor: Colors.black,
//                           minLines: 1,
//                           maxLines: 10,
//                           focusNode: focusNode,
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 14.0),
//                           controller: textEditingController,
//                           onSubmitted: (value) async {
//                             await sendMessageFCT(chatProvider: chatProvider);
//                           },
//                           decoration: InputDecoration(
//                             hintText: "Hai, ada yang bisa saya bantu?",
//                             hintStyle: const TextStyle(color: Colors.grey),
//                             contentPadding: const EdgeInsets.only(
//                                 left: 15.0,
//                                 right: 15.0,
//                                 top: 10.0,
//                                 bottom: 10.0),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             filled: true,
//                             fillColor: const Color(0xFFF6F6F6),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () async {
//                         await sendMessageFCT(chatProvider: chatProvider);
//                       },
//                       icon: const Icon(
//                         Icons.send,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void scrollListToEND() {
//     _listScrollController.animateTo(
//         _listScrollController.position.maxScrollExtent,
//         duration: const Duration(seconds: 2),
//         curve: Curves.easeOut);
//   }
//
//   Future<void> sendMessageFCT({required ChatProvider chatProvider}) async {
//     if (_isTyping) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: UserInput(
//             label: "You cant send multiple messages at a time",
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//     if (textEditingController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: UserInput(
//             label: "Please type a message",
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//     try {
//       String msg = textEditingController.text;
//       setState(() {
//         _isTyping = true;
//         chatProvider.addUserMessage(msg: msg);
//         textEditingController.clear();
//         focusNode.unfocus();
//       });
//       await chatProvider.sendMessageAndGetAnswers(msg: msg);
//       setState(() {});
//     } catch (error) {
//       log("error $error");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: UserInput(
//           label: error.toString(),
//         ),
//         backgroundColor: Colors.red,
//       ));
//     } finally {
//       setState(() {
//         scrollListToEND();
//         _isTyping = false;
//       });
//     }
//   }
// }
