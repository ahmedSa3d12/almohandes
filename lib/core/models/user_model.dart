// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

UserModel loginModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String loginModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.data,
    this.message,
    this.code,
  });

  final User? data;
  final String? message;
  final int? code;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: json["data"] != null ? User.fromJson(json["data"]) : null,
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class User {
  int id;
  String name;
  String email;
  dynamic photo;
  String phone;
  int countryId;
  int governorateId;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photo,
    required this.phone,
    required this.countryId,
    required this.governorateId,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"]??"",
    photo: json["photo"],
    phone: json["phone"]??'',
    countryId: json["country_id"]??0,
    governorateId: json["governorate_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    token: json["token"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "photo": photo,
    "phone": phone,
    "country_id": countryId,
    "governorate_id": governorateId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "token": token,
  };
}
