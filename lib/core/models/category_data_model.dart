import 'category_model.dart';

class CategoryDataModel {
  String message;
  int code;
  List<CategoryModel> data;

  CategoryDataModel({
    required this.message,
    required this.code,
    required this.data,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
    message: json["message"],
    code: json["code"],
    data: List<CategoryModel>.from(json["data"].map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

