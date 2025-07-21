import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/features/Notification/data/models/contest_for_notification_model.dart';
import 'package:skill_bridge_mobile/features/Notification/data/models/notification_model.dart';
import 'package:skill_bridge_mobile/features/Notification/data/models/sender_or_reciever_model.dart';
import 'package:skill_bridge_mobile/features/Notification/domain/entities/notification.dart';

class NotificationsGeneralModel extends Notification {
  const NotificationsGeneralModel(
      {required super.contest,
      required super.seen,
      required super.type,
      required super.date,
      required super.id,
      required super.notification,
      super.sender,
      super.receiver,
      super.requestId,
      super.userId,
      super.invitedBy,
      super.invitedById});
  factory NotificationsGeneralModel.fromJson(Map<String, dynamic> json) {
    return NotificationsGeneralModel(
        contest: json['contest'] != null
            ? ContestForNotificationModel.fromJson(json['contest'])
            : null,
        invitedBy:
            json['invitedBy'] != null ? json['invitedBy']['firstName'] : null,
        invitedById:
            json['invitedBy'] != null ? json['invitedBy']['_id'] : null,
        seen: json['seen'] ?? false,
        type: getNotificationTypes(json['type'] ?? ''),
        date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
        id: json['_id'],
        notification: NotificationModel.fromJson(json['notification'] ?? {}),
        receiver: json['receiver'] != null
            ? SenderOrRecieverModel.fromJson(json['receiver'])
            : null,
        sender: json['sender'] != null
            ? SenderOrRecieverModel.fromJson(json['sender'])
            : null,
        requestId: json['friendRequestId'],
        userId: json['userId']);
  }
}

NotificationTypes getNotificationTypes(String type) {
  switch (type) {
    case "FRIEND_REQUEST":
      return NotificationTypes.friendRequest;
    case "ACCEPTED_REQUEST":
      return NotificationTypes.accepterdFriendRequest;
    case "INVITED_CONTEST":
      return NotificationTypes.invitedContest;
    case "REGISTERED_CONTEST":
      return NotificationTypes.registeredContest;
    case "CONTEST_WINNER":
      return NotificationTypes.contestWinner;
    case "STUDY_REMINDER":
      return NotificationTypes.studyReminder;
    case "CUSTOM_CONTEST_INVITATION":
      return NotificationTypes.customeContestInvite;
    case "CUSTOM_CONTEST_REGISTERED":
      return NotificationTypes.customeContestRegistered;
    case "PROGRESS_CONTENT":
      return NotificationTypes.weeklyProgressReport;
    default:
      throw NotificationTypes.general;
  }
}
