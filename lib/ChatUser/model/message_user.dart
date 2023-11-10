import '../utils.dart';

class MessageUserField {
  static const String createdAt = 'createdAt';
}

class MessageUser {
  final String idUser;
  final String urlAvatar;
  final String username;
  final String message;
  final DateTime? createdAt;

  const MessageUser({
    required this.idUser,
    required this.urlAvatar,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  static MessageUser fromJson(Map<String, dynamic> json) {
    return MessageUser(
      idUser: json['idUser'] ?? '',
      urlAvatar: json['urlAvatar'] ?? '',
      username: json['username'] ?? '',
      message: json['message'] ?? '',
      createdAt: Utils.toDateTime(json['createdAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}
