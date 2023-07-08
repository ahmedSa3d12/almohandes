import 'message_data_model.dart';

class SingleMessageModel {
  MessageModel data;
  String message;
  int code;

  SingleMessageModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SingleMessageModel.fromJson(Map<String, dynamic> json) => SingleMessageModel(
    data: MessageModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}