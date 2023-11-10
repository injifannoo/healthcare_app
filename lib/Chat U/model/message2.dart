import '../utils.dart';

class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  final String idUser;
  final String urlAvatar;
  final String username;
  final String message;
  final String recieverId;
  final DateTime? createdAt;

  const Message({
    required this.idUser,
    required this.recieverId,
    required this.urlAvatar,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      idUser: json['idUser'] ?? '',
      urlAvatar: json['urlAvatar'] ?? '',
      username: json['username'] ?? '',
      message: json['message'] ?? '',
      recieverId: json['recieverId'] ?? '',
      createdAt: Utils.toDateTime(json['createdAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'recieverId': recieverId,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}
