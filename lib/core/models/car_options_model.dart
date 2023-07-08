class CarOptionsModel {
  String message;
  int code;
  List<OptionsModel> data;

  CarOptionsModel({
    required this.message,
    required this.code,
    required this.data,
  });

  factory CarOptionsModel.fromJson(Map<String, dynamic> json) => CarOptionsModel(
    message: json["message"],
    code: json["code"],
    data: List<OptionsModel>.from(json["data"].map((x) => OptionsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OptionsModel {
  int id;
  String titleAr;
  String titleEn;
  String title;
bool isselected=false;
  OptionsModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.title,
  });

  factory OptionsModel.fromJson(Map<String, dynamic> json) => OptionsModel(
    id: json["id"],
    titleAr: json["title_ar"],
    titleEn: json["title_en"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_ar": titleAr,
    "title_en": titleEn,
    "title": title,
  };
}
