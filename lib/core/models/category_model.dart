class CategoryModel {
  int id;
  String titleAr;
  String titleEn;
  DateTime createdAt;
  DateTime updatedAt;
  String title;

  CategoryModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    titleAr: json["title_ar"],
    titleEn: json["title_en"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_ar": titleAr,
    "title_en": titleEn,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "title": title,
  };
}
