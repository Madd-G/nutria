import 'dart:convert';

class PredictionModel {
  List<Prediction>? data;

  PredictionModel({this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prediction {
  String classLabel;
  String className;

  // List<dynamic> bbox;
  String confidence;

  Prediction({
    required this.classLabel,
    required this.className,
    // required this.bbox,
    required this.confidence,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
        classLabel: json["class_label"],
        className: json["class_name"],
        // bbox: json["bbox"],
        confidence: json["confidence"]);
  }

  Map<String, dynamic> toJson() => {
        "class_label": classLabel,
        "class_name": className,
        // "bbox": bbox,
        "confidence": confidence,
      };
}

List<Prediction> modelFromJson(String str) {
  return List<Prediction>.from(
      json.decode(str).map((x) => Prediction.fromJson(x)));
}

String modelToJson(List<Prediction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
