// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// // class HistoryModel {
// //   List<History>? data;
// //
// //   HistoryModel({
// //     this.data,
// //   });
// //
// //   HistoryModel.fromJson(Map<String, dynamic> json) {
// //     if (json['data'] != null) {
// //       data = <History>[];
// //       json['data'].forEach((v) {
// //         data!.add(History.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     if (this.data != null) {
// //       data['data'] = this.data!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }
//
// List<History> historyModelFromJson(String str) {
//   // print('modelFromJson prediction_model');
//   return List<History>.from(json.decode(str).map((x) => History.fromJson(x)));
// }
//
// class History {
//   // String? id;
//   String? className;
//   String? confidence;
//
//   // FieldValue? timestamp;
//
//   History({
//     // this.id,
//     this.className,
//     this.confidence,
//     // this.timestamp
//   });
//
//   factory History.fromRTDB(Map<String, dynamic> data) {
//     return History(
//       className: data['className'],
//       confidence: data['confidence'],
//     );
//   }
//
//   History.fromJson(Map<String, dynamic> json) {
//     // id = json['id'];
//     className = json['name'];
//     confidence = json['confidence'];
//     // timestamp = json['timestamp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // data['id'] = id;
//     data['name'] = className;
//     data['confidence'] = confidence;
//     // data['timestamp'] = timestamp;
//     return data;
//   }
// }
//
// List<History> historymodelFromJson(String str) {
//   return List<History>.from(jsonDecode(str).map((x) => History.fromJson(x)));
// }
//
// String historyModelToJson(List<History> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
