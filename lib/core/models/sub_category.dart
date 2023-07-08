class SubCategory {
  int id;
  String titleAr;
  String titleEn;
  int categoryId;
  DateTime createdAt;
  DateTime updatedAt;
  String title;

  SubCategory({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    titleAr: json["title_ar"],
    titleEn: json["title_en"],
    categoryId: json["category_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_ar": titleAr,
    "title_en": titleEn,
    "category_id": categoryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "title": title,
  };
}
