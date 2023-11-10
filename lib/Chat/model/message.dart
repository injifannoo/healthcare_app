import '../utils.dart';

class MessageField {
  static const String createdAt = 'createdAt';
  static const String idUser = 'idUser';
}

class Message {
  final String idUser;
  final String recieverId;
  final String urlAvatar;
  final String username;
  final String message;
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
      recieverId: json['recieverId'] ?? '',
      urlAvatar: json['urlAvatar'] ?? '',
      username: json['username'] ?? '',
      message: json['message'] ?? '',
      createdAt: Utils.toDateTime(json['createdAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'recieverId': recieverId,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}
