// class Model {
//   Data? data;
//
//   Model({this.data});
//
//   Model.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? description;
//   String? category;
//   String? nutrients;
//   String? benefits;
//
//   Data(
//       {this.id,
//       this.name,
//       this.description,
//       this.category,
//       this.nutrients,
//       this.benefits});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     category = json['category'];
//     nutrients = json['nutrients'];
//     benefits = json['benefits'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['description'] = description;
//     data['category'] = category;
//     data['nutrients'] = nutrients;
//     data['benefits'] = benefits;
//     return data;
//   }
// }
