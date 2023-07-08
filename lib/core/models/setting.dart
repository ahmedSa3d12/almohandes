class SettingData {
  Data data;
  String message;
  int code;

  SettingData({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  int id;
  String logo;
  String title;
  String aboutUsAr;
  String aboutUsEn;
  String termsAr;
  String termsEn;
  String privacyAr;
  String privacyEn;
  dynamic email;
  String phone;
  String facebook;
  dynamic twitter;
  dynamic youtube;
  dynamic gmail;
  dynamic times;
  dynamic createdAt;
  DateTime updatedAt;
  String termsLink;
  String privacy;

  Data({
    required this.id,
    required this.logo,
    required this.title,
    required this.aboutUsAr,
    required this.aboutUsEn,
    required this.termsAr,
    required this.termsEn,
    required this.privacyAr,
    required this.privacyEn,
    this.email,
    required this.phone,
    required this.facebook,
    this.twitter,
    this.youtube,
    this.gmail,
    this.times,
    this.createdAt,
    required this.updatedAt,
    required this.termsLink,
    required this.privacy,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    logo: json["logo"],
    title: json["title"],
    aboutUsAr: json["about_us_ar"],
    aboutUsEn: json["about_us_en"],
    termsAr: json["terms_ar"],
    termsEn: json["terms_en"],
    privacyAr: json["privacy_ar"],
    privacyEn: json["privacy_en"],
    email: json["email"],
    phone: json["phone"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    gmail: json["gmail"],
    times: json["times"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    termsLink: json["terms_link"],
    privacy: json["privacy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo": logo,
    "title": title,
    "about_us_ar": aboutUsAr,
    "about_us_en": aboutUsEn,
    "terms_ar": termsAr,
    "terms_en": termsEn,
    "privacy_ar": privacyAr,
    "privacy_en": privacyEn,
    "email": email,
    "phone": phone,
    "facebook": facebook,
    "twitter": twitter,
    "youtube": youtube,
    "gmail": gmail,
    "times": times,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "terms_link": termsLink,
    "privacy": privacy,
  };
}
