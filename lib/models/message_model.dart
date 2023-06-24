// class MessageModel {
//   final String msg;
//   final int chatIndex;
//
//   MessageModel({required this.msg, required this.chatIndex});
//
//   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
//     msg: json["msg"],
//     chatIndex: json["chatIndex"],
//   );
// }
//
// class ModelsModel {
//   final String id;
//   final int created;
//   final String root;
//
//   ModelsModel({
//     required this.id,
//     required this.root,
//     required this.created,
//   });
//
//   factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
//     id: json["id"],
//     root: json["root"],
//     created: json["created"],
//   );
//
//   static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
//     return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
//   }
// }
//
//
