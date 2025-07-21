import 'package:skill_bridge_mobile/features/Notification/data/models/notification_general_model.dart';
import 'package:skill_bridge_mobile/features/Notification/data/models/notification_model.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/friend_related_notification_entity.dart';

class FriendRelatedNotificationModel extends FriendRelatedNotificationEntity {
  const FriendRelatedNotificationModel({
    required super.notification,
    required super.requestId,
    required super.date,
    required super.seen,
    required super.type,
  });
  factory FriendRelatedNotificationModel.fromJson(Map<String, dynamic> json) {
    return FriendRelatedNotificationModel(
      notification: NotificationModel.fromJson(json['notification']),
      requestId: json['friendRequestId'],
      date: DateTime(json['date']),
      seen: json['seen'] ?? false,
      type: getNotificationTypes(json['type'] ?? ''),
    );
  }
}
