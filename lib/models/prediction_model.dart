import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class PredictionModel {
  List<Prediction>? data;

  PredictionModel({this.data});

  PredictionModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    if (json['objects'] != null) {
      data = <Prediction>[];
      json['objects'].forEach((v) {
        data!.add(Prediction.fromJson(v));
      });
    }
  }

  factory PredictionModel.fromSnapshotSecond(DocumentSnapshot<Map<String, dynamic>> document) {
    print('PredictionModel getting data');
    final dats = document.data()!;
    if (document['objects'] != null) {
      var datas = <Prediction>[];
      dats['objects'].forEach((v) {
        print('***** v $v');
        datas.add(Prediction.fromJson(v));
      });
      print('datas: ${datas}');
      return PredictionModel(
        data: datas,
      );
    }

    print('PredictionModel ++++ data $dats');
    print('PredictionModel ---- data ${dats['objects']}');
    return PredictionModel(
      data: dats['objects'],
    );
  }

  factory PredictionModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    print('PredictionModel getting data');
    final dats = document.data()!;
    print('PredictionModel ++++ data $dats');
    print('PredictionModel ---- data ${dats['objects']}');
    return PredictionModel(
      data: dats['objects'],
    );
  }

  // factory Prediction.fromJson(Map<String, dynamic> json) {
  //   return Prediction(
  //   data:
  //       // classLabel: json["class_label"],
  // }

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

  factory Prediction.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    print('getting data');
    final data = document.data()!;
    print('++++ data $data');
    print('---- data ${data['objects'][0]['className']}');
    return Prediction(
      classLabel: data['objects'][1]['classLabel'],
      className: data['objects'][1]['className'],
      confidence: data['objects'][1]['confidence'],
    );
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
