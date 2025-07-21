import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';

class SearchFriendsModel extends FriendEntity {
  const SearchFriendsModel({
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
  });
  factory SearchFriendsModel.fromJson(Map<String, dynamic> json) {
    return SearchFriendsModel(
      id: json['_id'] ?? '',
      email_phone: json['email_phone'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      departmentId: json['department'] ?? '',
      avatar: json['avatarImage'],
      grade: json['grade'] ?? 12, //! review
      school: json['highSchool'] ?? '',
      point: json['statistics'] != null ? json['statistics']['points'] ?? 0 : 0,
      maxStreak:
          json['statistics'] != null ? json['statistics']['maxStreak'] ?? 0 : 0,
      requestStatus: json['status'],
    );
  }
}
