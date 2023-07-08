import 'country_model.dart';

class CountryDataModel {
  String message;
  int code;
  List<CountryModel> data;

  CountryDataModel({
    required this.message,
    required this.code,
    required this.data,
  });

  factory CountryDataModel.fromJson(Map<String, dynamic> json) => CountryDataModel(
    message: json["message"],
    code: json["code"],
    data: List<CountryModel>.from(json["data"].map((x) => CountryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}