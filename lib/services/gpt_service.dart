// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:nutria/models/models.dart';
// import 'package:http/http.dart' as http;
//
// String baseUrl = "https://api.openai.com/v1";
// String apiKey = "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";
//
// class ApiService {
//   // Send Message using ChatGPT API
//   static Future<List<MessageModel>> sendMessageGPT(
//       {required String message, required String modelId}) async {
//     try {
//       print('sendMessageGPT');
//       log("modelId $modelId");
//       var response = await http.post(
//         Uri.parse("$baseUrl/chat/completions"),
//         headers: {
//           'Authorization': 'Bearer $apiKey',
//           "Content-Type": "application/json"
//         },
//         body: jsonEncode(
//           {
//             "model": modelId,
//             "messages": [
//               {
//                 "role": "user",
//                 "content": message,
//               }
//             ]
//           },
//         ),
//       );
//
//       // Map jsonResponse = jsonDecode(response.body);
//       Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
//       if (jsonResponse['error'] != null) {
//         // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
//         throw HttpException(jsonResponse['error']["message"]);
//       }
//       List<MessageModel> chatList = [];
//       if (jsonResponse["choices"].length > 0) {
//         // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
//         chatList = List.generate(
//           jsonResponse["choices"].length,
//           (index) => MessageModel(
//             msg: jsonResponse["choices"][index]["message"]["content"],
//             chatIndex: 1,
//           ),
//         );
//       }
//       return chatList;
//     } catch (error) {
//       log("error $error");
//       rethrow;
//     }
//   }
// }
