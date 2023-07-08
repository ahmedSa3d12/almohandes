// To parse this JSON data, do
//
//     final CarsDataModel = CarsDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:engwheels/core/models/user_model.dart';

import 'cars_model.dart';
import 'country_model.dart';



class CarsDataModel {
  String message;
  int code;
  List<CarsModel> data;

  CarsDataModel({
    required this.message,
    required this.code,
    required this.data,
  });

  factory CarsDataModel.fromJson(Map<String, dynamic> json) => CarsDataModel(
    message: json["message"],
    code: json["code"],
    data: List<CarsModel>.from(json["data"].map((x) => CarsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}



