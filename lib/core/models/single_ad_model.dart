import 'cars_model.dart';

class SingleAdModel {
  CarsModel data;
  String message;
  int code;

  SingleAdModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SingleAdModel.fromJson(Map<String, dynamic> json) => SingleAdModel(
    data: CarsModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}