import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';

class SentRequestsModel extends FriendEntity {
  const SentRequestsModel({
    required super.id,
    required super.email_phone,
    required super.firstName,
    required super.lastName,
    required super.departmentId,
    required super.avatar,
    required super.grade,
    required super.school,
    required super.point,
    required super.maxStreak,
    required super.requestStatus,
    required super.requestId,
  });
  factory SentRequestsModel.fromJson(Map<String, dynamic> json) {
    return SentRequestsModel(
      id: json['_id'] ?? '',
      email_phone: json['email_phone'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      departmentId: json['department'] ?? '',
      avatar: json['avatar'],
      grade: json['grade'] ?? 12,
      school: json['highSchool'] ?? '',
      point: json['points'] ?? 0,
      maxStreak: json['maxStreak'] ?? '',
      requestStatus: json['status'] ?? '',
      requestId: json['requestId'],
    );
  }
}
