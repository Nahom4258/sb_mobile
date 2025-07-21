import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  final String id;
  final String requestId;
  final String emailOrPhone;
  final String firstName;
  final String lastName;
  final String highSchoolName;
  final String avatar;
  final String region;
  final String contestStatus;
  final double points;
  final int maxStreak;
  final int currentStreak;
  final bool isCurrentUser;

  const Friend({
    required this.id,
    required this.requestId,
    required this.emailOrPhone,
    required this.firstName,
    required this.lastName,
    required this.highSchoolName,
    required this.avatar,
    required this.region,
    required this.contestStatus,
    required this.points,
    required this.maxStreak,
    required this.currentStreak,
    required this.isCurrentUser,
  });


  @override
  List<Object?> get props => [
    id,
    requestId,
    emailOrPhone,
    firstName,
    lastName,
    highSchoolName,
    avatar,
    region,
    contestStatus,
    points,
    maxStreak,
    currentStreak,
    isCurrentUser,
  ];
}