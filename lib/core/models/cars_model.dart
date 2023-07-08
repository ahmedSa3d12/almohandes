import 'package:engwheels/core/models/user_model.dart';

import 'country_model.dart';

class CarsModel {
  int id;
  String? image;
  String description;
  int price;
  String installmentAvailable;
  int categoryId;
  int subCategoryId;
  int countryId;
  int governorateId;
  String? kilometre;
  String? engineCapacity;
  String? color;
  DateTime createdAt;
  DateTime updatedAt;
  int? userId;
  Category category;
  CountryModel country;
  Governorate governorate;
  Category subCategory;
  List<Image> images;
  List<DatumDatum> data;
  User? user;
  List<OptionElement> options;

  CarsModel({
    required this.id,
    this.image,
    required this.description,
    required this.price,
    required this.installmentAvailable,
    required this.categoryId,
    required this.subCategoryId,
    required this.countryId,
    required this.governorateId,
    this.kilometre,
    this.engineCapacity,
    this.color,
    required this.createdAt,
    required this.updatedAt,
    this.userId,
    required this.category,
    required this.country,
    required this.governorate,
    required this.subCategory,
    required this.images,
    required this.data,
    this.user,
    required this.options,
  });

  factory CarsModel.fromJson(Map<String, dynamic> json) => CarsModel(
    id: json["id"],
    image: json["image"],
    description: json["description"],
    price: json["price"],
    installmentAvailable: json["Installment_available"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    countryId: json["country_id"],
    governorateId: json["governorate_id"],
    kilometre: json["kilometre"],
    engineCapacity: json["engine_capacity"],
    color: json["color"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    category: Category.fromJson(json["category"]),
    country: CountryModel.fromJson(json["country"]),
    governorate: Governorate.fromJson(json["governorate"]),
    subCategory: Category.fromJson(json["sub_category"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    data: List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    options: List<OptionElement>.from(json["options"].map((x) => OptionElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "description": description,
    "price": price,
    "Installment_available": installmentAvailable,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "country_id": countryId,
    "governorate_id": governorateId,
    "kilometre": kilometre,
    "engine_capacity": engineCapacity,
    "color": color,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user_id": userId,
    "category": category.toJson(),
    "country": country.toJson(),
    "governorate": governorate.toJson(),
    "sub_category": subCategory.toJson(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "user": user?.toJson(),
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Category {
  int id;
  String titleAr;
  String titleEn;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  int? categoryId;

  Category({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    titleAr: json["title_ar"],
    titleEn: json["title_en"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    title: json["title"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_ar": titleAr,
    "title_en": titleEn,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "title": title,
    "category_id": categoryId,
  };
}


class DatumDatum {
  int id;
  String key;
  String value;
  int carId;
  DateTime createdAt;
  DateTime updatedAt;

  DatumDatum({
    required this.id,
    required this.key,
    required this.value,
    required this.carId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
    carId: json["car_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
    "car_id": carId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Governorate {
  int id;
  int countryId;
  String governorateNameAr;
  String governorateNameEn;

  Governorate({
    required this.id,
    required this.countryId,
    required this.governorateNameAr,
    required this.governorateNameEn,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
    id: json["id"],
    countryId: json["country_id"],
    governorateNameAr: json["governorate_name_ar"],
    governorateNameEn: json["governorate_name_en"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "governorate_name_ar": governorateNameAr,
    "governorate_name_en": governorateNameEn,
  };
}

class Image {
  int id;
  String image;
  int carId;
  DateTime createdAt;
  DateTime updatedAt;

  Image({
    required this.id,
    required this.image,
    required this.carId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    image: json["image"],
    carId: json["car_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "car_id": carId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class OptionElement {
  int id;
  int carId;
  int optionId;
  OptionOption option;

  OptionElement({
    required this.id,
    required this.carId,
    required this.optionId,
    required this.option,
  });

  factory OptionElement.fromJson(Map<String, dynamic> json) => OptionElement(
    id: json["id"],
    carId: json["car_id"],
    optionId: json["option_id"],
    option: OptionOption.fromJson(json["option"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "car_id": carId,
    "option_id": optionId,
    "option": option.toJson(),
  };
}

class OptionOption {
  int id;
  String titleAr;
  String titleEn;
  String title;

  OptionOption({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.title,
  });

  factory OptionOption.fromJson(Map<String, dynamic> json) => OptionOption(
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