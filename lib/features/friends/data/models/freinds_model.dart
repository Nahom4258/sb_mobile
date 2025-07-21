import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';

class FriendsModel extends FriendEntity {
  const FriendsModel({
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
  });
  factory FriendsModel.fromJson(Map<String, dynamic> json) {
    return FriendsModel(
      id: json['_id'] ?? '',
      email_phone: json['email_phone'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      departmentId: json['department'] ?? '',
      avatar: json['avatar'],
      grade: json['grade'] ?? 12,
      school: json['highSchool'] ?? '',
      point: json['points'] ?? 0,
      maxStreak: json['maxStreak'] ?? 0,
    );
  }
  
  factory FriendsModel.fromCustomContestJson(Map<String, dynamic> json) {
    return FriendsModel(
        id: json['userId'] ?? '',
        email_phone: json['email_phone'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        departmentId: json['departmentId'] ?? '',
        avatar: json['avatar'] == null ? null : json['avatar']['imageAddress'],
        grade: json['grade'] ?? 0,
        school: json['school'] ?? '',
        point: json['points'] ?? 0,
        maxStreak: json['maxStreak'] ?? 0,
    );
  }
}
