import 'sub_category.dart';

class SubCategoryModel {
  String message;
  int code;
  List<SubCategory> data;

  SubCategoryModel({
    required this.message,
    required this.code,
    required this.data,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    message: json["message"],
    code: json["code"],
    data: List<SubCategory>.from(json["data"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

