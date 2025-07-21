import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification_entity.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/sender_or_reciever_entity.dart';

class FriendRelatedNotificationEntity extends Equatable {
  final NotificationEntity notification;
  final SenderOrRecieverEntity? sender;
  final SenderOrRecieverEntity? receiver;
  final String requestId;
  final DateTime date;
  final bool seen;
  final NotificationTypes type;

  const FriendRelatedNotificationEntity({
    required this.notification,
    this.sender,
    this.receiver,
    required this.requestId,
    required this.date,
    required this.seen,
    required this.type,
  });
  @override
  List<Object?> get props => [
        notification,
        sender,
        receiver,
        requestId,
        date,
        seen,
        type,
      ];
}
