class CountryModel {
  int id;
  String titleAr;
  String titleEn;
  String image;
  String phoneCode;
  String currencyAr;
  String currencyEn;

  CountryModel({
     this.id=0,
     this.titleAr='',
     this.titleEn='',
     this.image='',
     this.phoneCode='',
     this.currencyAr='',
     this.currencyEn='',
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["id"],
    titleAr: json["title_ar"],
    titleEn: json["title_en"],
    image: json["image"],
    phoneCode: json["phone_code"],
    currencyAr: json["currency_ar"],
    currencyEn: json["currency_en"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_ar": titleAr,
    "title_en": titleEn,
    "image": image,
    "phone_code": phoneCode,
    "currency_ar": currencyAr,
    "currency_en": currencyEn,
  };
}
