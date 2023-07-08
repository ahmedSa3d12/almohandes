
class NewsModel {
  String message;
  int code;
  List<NewsData> data;

  NewsModel({
    required this.message,
    required this.code,
    required this.data,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    message: json["message"],
    code: json["code"],
    data: List<NewsData>.from(json["data"].map((x) => NewsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NewsData {
  int id;
  String photo;
  String titleAr;
  String titleEn;
  String descAr;
  String descEn;
  String createdAt;
  String updatedAt;

  NewsData({
    required this.id,
    required this.photo,
    required this.titleAr,
    required this.titleEn,
    required this.descAr,
    required this.descEn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
    id: json["id"],
    photo: json["photo"],
    titleAr: json["title_ar"],
    titleEn: json["title_en"],
    descAr: json["desc_ar"],
    descEn: json["desc_en"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photo": photo,
    "title_ar": titleAr,
    "title_en": titleEn,
    "desc_ar": descAr,
    "desc_en": descEn,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
