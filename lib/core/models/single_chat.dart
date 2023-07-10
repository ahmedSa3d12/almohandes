import 'chat_data_model.dart';

class SingleChatModel {
  ChatModel data;
  String message;
  int code;

  SingleChatModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SingleChatModel.fromJson(Map<String, dynamic> json) => SingleChatModel(
    data: ChatModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}



