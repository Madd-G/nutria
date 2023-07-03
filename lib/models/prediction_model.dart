import 'dart:convert';

import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  final String classLabel;
  final String className;

  // List<dynamic> bbox;
  final String confidence;

  const Prediction({
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

  @override
  List<Object?> get props => [classLabel, className, confidence];
}

List<Prediction> modelFromJson(String str) {
  return List<Prediction>.from(
      json.decode(str).map((x) => Prediction.fromJson(x)));
}

String modelToJson(List<Prediction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
