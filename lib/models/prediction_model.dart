import 'dart:convert';

class PredictionModel {
  int classLabel;
  String className;
  List<dynamic> bbox;
  String confidence;

  PredictionModel({
    required this.classLabel,
    required this.className,
    required this.bbox,
    required this.confidence,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
        classLabel: json["class_label"],
        className: json["class_name"],
        bbox: json["bbox"],
        confidence: json["confidence"]);
  }

  Map<String, dynamic> toJson() => {
        "class_label": classLabel,
        "class_name": className,
        "bbox": bbox,
        "confidence": confidence,
      };
}

List<PredictionModel> modelFromJson(String str) {
  return List<PredictionModel>.from(
      json.decode(str).map((x) => PredictionModel.fromJson(x)));
}

// String modelToJson(List<PredictionModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
