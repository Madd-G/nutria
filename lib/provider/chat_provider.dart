// import 'package:flutter/material.dart';
// import 'package:nutria/services/gpt_service.dart';
//
// import '../../models/models.dart';
// import '../models/message_model.dart';
//
// class ChatProvider with ChangeNotifier {
//   List<MessageModel> chatList = [];
//
//   List<MessageModel> get getChatList {
//     return chatList;
//   }
//
//   void addUserMessage({required String msg}) {
//     chatList.add(MessageModel(msg: msg, chatIndex: 0));
//     notifyListeners();
//   }
//
//   Future<void> sendMessageAndGetAnswers({required String msg}) async {
//     chatList.addAll(await ApiService.sendMessageGPT(
//       message: msg,
//       modelId: 'gpt-3.5-turbo-0301',
//     ));
//     notifyListeners();
//   }
// }
