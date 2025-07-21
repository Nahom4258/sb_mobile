import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/contest_for_notification_entity.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification_entity.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/sender_or_reciever_entity.dart';

class Notification extends Equatable {
  final ContestForNotificationEntity? contest;
  final bool seen;
  final NotificationTypes type;
  final DateTime date;
  final String id;
  final NotificationEntity notification;
  final SenderOrRecieverEntity? sender;
  final SenderOrRecieverEntity? receiver;
  final String? requestId;
  final String? userId;
  final String? invitedBy;
  final String? invitedById;
  const Notification(
      {this.contest,
      required this.seen,
      required this.type,
      required this.date,
      required this.id,
      required this.notification,
      this.sender,
      this.receiver,
      this.requestId,
      this.userId,
      this.invitedBy,
      this.invitedById});

  @override
  List<Object?> get props => [
        contest,
        seen,
        type,
        date,
        id,
        notification,
        sender,
        receiver,
        requestId,
        userId,
        invitedBy,
        invitedById
      ];
}
