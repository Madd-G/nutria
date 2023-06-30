import 'dart:convert';

class DataModel {
  List<Data>? data;

  DataModel({
    this.data,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

List<Data> dataModelFromJson(String str) {
  // print('modelFromJson prediction_model');
  return List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));
}

class Data {
  String? id;
  String? name;
  String? description;
  String? category;
  List<String>? nutrients;
  String? benefits;

  // FieldValue? timestamp;

  Data({
    this.id,
    this.name,
    this.description,
    this.category,
    this.nutrients,
    this.benefits,
    // this.timestamp
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    nutrients = json['nutrients'];
    benefits = json['benefits'];
    // timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['category'] = category;
    data['nutrients'] = nutrients;
    data['benefits'] = benefits;
    // data['timestamp'] = timestamp;
    return data;
  }
}
