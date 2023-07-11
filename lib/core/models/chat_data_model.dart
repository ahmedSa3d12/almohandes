// To parse this JSON data, do
//
//     final ChatDataModel = ChatDataModelFromJson(jsonString);

import 'dart:convert';


class ChatDataModel {
  List<ChatModel> data;
  String message;
  int code;

  ChatDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory ChatDataModel.fromJson(Map<String, dynamic> json) => ChatDataModel(
    data: List<ChatModel>.from(json["data"].map((x) => ChatModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class ChatModel {
  int id;
  String name;
  String email;
  dynamic code;
  String photo;
  String phoneCode;
  String? phone;
  int countryId;
  int governorateId;
  String createdAt;
  String updatedAt;
  LastMessage lastMessage;
  int unreadMessageNumber;

  ChatModel({
    required this.id,
    required this.name,
    required this.email,
    this.code,
    required this.photo,
    required this.phoneCode,
    this.phone,
    required this.countryId,
    required this.governorateId,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
    required this.unreadMessageNumber,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    code: json["code"],
    photo: json["photo"]??"",
    phoneCode: json["phone_code"],
    phone: json["phone"],
    countryId: json["country_id"],
    governorateId: json["governorate_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    lastMessage: LastMessage.fromJson(json["last_message"]),
    unreadMessageNumber: json["unread_message_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "code": code,
    "photo": photo,
    "phone_code": phoneCode,
    "phone": phone,
    "country_id": countryId,
    "governorate_id": governorateId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "last_message": lastMessage.toJson(),
    "unread_message_number": unreadMessageNumber,
  };
}

class LastMessage {
  String text;
  String date;

  LastMessage({
    required this.text,
    required this.date,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    text: json["text"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "date": date
  };
}
