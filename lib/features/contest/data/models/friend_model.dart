import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';

class FriendModel extends Friend {
  const FriendModel({
    required super.id,
    required super.requestId,
    required super.emailOrPhone,
    required super.firstName,
    required super.lastName,
    required super.highSchoolName,
    required super.avatar,
    required super.region,
    required super.contestStatus,
    required super.points,
    required super.maxStreak,
    required super.currentStreak,
    required super.isCurrentUser,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
        id: json['_id'] ?? '',
        requestId: json['requestId']?? '',
        emailOrPhone: json['email_phone'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        highSchoolName: json['highSchoolName'] ?? '',
        avatar: json['avatar'] ?? defaultProfileAvatar,
        region: json['region'] ?? '',
        contestStatus: json['contestStatus'] ?? '',
        points: (json['points'] ?? 0).toDouble(),
        maxStreak: json['maxStreak'] ?? 0,
        currentStreak: json['currentStreak'] ?? 0,
        isCurrentUser: json['isCurrentUser'] ?? false,
    );
  }

}