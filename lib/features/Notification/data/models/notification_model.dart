import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.notificationId,
    required super.title,
    required super.content,
    required super.date,
    required super.isPersonal,
    // supper.userId,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      isPersonal: json['isPersonal'] ?? false,
    );
  }
}
