part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

enum HomeStatus { loading, loaded, error }

class GetMyCoursesState extends HomeState {
  final HomeStatus status;
  final List<UserCourse>? userCourses;

  const GetMyCoursesState({
    required this.status,
    this.userCourses,
  });

  @override
  List<Object?> get props => [status, userCourses];
}

class GetHomeState extends HomeState {
  const GetHomeState({
    required this.status,
    this.lastStartedChapter,
    this.examDates,
    this.recommendedMocks,
    this.failure,
    this.rank,
    this.coins,
    this.totalUsers,
    this.referralCount,
    this.totalUnseenNotifications,
  });

  final HomeStatus status;
  final HomeChapter? lastStartedChapter;
  final List<ExamDate>? examDates;
  final List<HomeMock>? recommendedMocks;
  final Failure? failure;
  final int? rank;
  final num? coins;
  final int? totalUsers;
  final num? referralCount;
  final int? totalUnseenNotifications;

  @override
  List<Object?> get props => [
        status,
        lastStartedChapter,
        examDates,
        recommendedMocks,
        failure,
        rank,
        coins,
        totalUsers,
        referralCount,
        totalUnseenNotifications
      ];
}
