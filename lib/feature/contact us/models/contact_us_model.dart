
import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
     this.data,
     this.message,
     this.code,
  });

  final ContactUsData? data;
  final String? message;
  final int? code;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    data: ContactUsData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
    "code": code,
  };
}

class ContactUsData {
  ContactUsData({
     this.name,
     this.phone,
     this.subject,
     this.message,
     this.id,
    this.email,
  });

  final String? name;
  final String? phone;
  final String? subject;
  final String? message;
  final int? id;
  final String? email;

  factory ContactUsData.fromJson(Map<String, dynamic> json) => ContactUsData(
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    subject: json["title"],
    message: json["message"],
    id: json["id"],

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
    "title": subject,
    "message": message,
  };
}
