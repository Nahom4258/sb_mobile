import 'package:skill_bridge_mobile/features/Notification/domain/entities/contest_for_notification_entity.dart';

class ContestForNotificationModel extends ContestForNotificationEntity {
  const ContestForNotificationModel({
    required super.id,
    required super.description,
     super.departmentId,
    required super.title,
    required super.virtualRegister,
    required super.liveRegister,
    required super.startsAt,
    required super.endsAt,
  });
  factory ContestForNotificationModel.fromJson(Map<String, dynamic> json) {
    return ContestForNotificationModel(
      id: json['_id'],
      description: json['description'],
      // departmentId: json['departmentId'],
      title: json['title'],
      virtualRegister: json['virtualRegister'],
      liveRegister: json['liveRegister'],
      startsAt:
          DateTime.parse(json['startsAt'] ?? DateTime.now().toIso8601String()),
      endsAt:
          DateTime.parse(json['endsAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
