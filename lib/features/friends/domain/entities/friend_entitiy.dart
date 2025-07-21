import 'package:equatable/equatable.dart';

class FriendEntity extends Equatable {
  final String id;
  final String email_phone;
  final String firstName;
  final String lastName;
  final String departmentId;
  final String? avatar;
  final int grade;
  final String school;
  final num point;
  final int maxStreak;
  final String? requestStatus;
  final String? requestId;

  const FriendEntity({
    this.requestId,
    required this.id,
    required this.email_phone,
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.avatar,
    required this.grade,
    required this.school,
    required this.point,
    required this.maxStreak,
    this.requestStatus,
  });
  @override
  List<Object?> get props => [
        id,
        email_phone,
        firstName,
        lastName,
        departmentId,
        avatar,
        school,
        point,
        maxStreak,
      ];
}
