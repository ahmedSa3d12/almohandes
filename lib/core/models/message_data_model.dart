class MessageDataModel {
  String message;
  int code;
  List<MessageModel> data;

  MessageDataModel({
    required this.message,
    required this.code,
    required this.data,
  });

  factory MessageDataModel.fromJson(Map<String, dynamic> json) => MessageDataModel(
    message: json["message"],
    code: json["code"],
    data: List<MessageModel>.from(json["data"].map((x) => MessageModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MessageModel {
  int id;
  int fromUserId;
  dynamic toUserId;
  DateTime date;
  String isRead;
  String time;
  dynamic image;
  String text;
  DateTime createdAt;
  DateTime updatedAt;

  MessageModel({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.date,
    required this.isRead,
    required this.time,
    this.image,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["id"],
    fromUserId: json["from_user_id"],
    toUserId: json["to_user_id"],
    date: DateTime.parse(json["date"]),
    isRead: json["is_read"]??"",
    time: json["time"],
    image: json["image"],
    text: json["text"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from_user_id": fromUserId,
    "to_user_id": toUserId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "is_read": isRead,
    "time": time,
    "image": image,
    "text": text,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
