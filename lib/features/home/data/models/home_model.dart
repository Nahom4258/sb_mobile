import 'package:skill_bridge_mobile/features/features.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.lastStartedChapter,
    required super.examDates,
    required super.homeMocks,
    required super.coin,
    required super.rank,
    required super.refferalCount,
    required super.tottalUserCount,
    required super.totalUnseenNotifications
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      lastStartedChapter: json['lastStartedCourse'] != null
          ? HomeChapterModel.fromJson(json['lastStartedCourse'])
          : null,
      examDates: (json['examDates'] ?? [])
          .map<ExamDateModel>((examDate) => ExamDateModel.fromJson(examDate))
          .toList(),
      homeMocks: (json['recommendedMocks'] ?? [])
          .map<HomeMockModel>((homeMock) => HomeMockModel.fromJson(homeMock))
          .toList(),
      coin: json['coin'] ?? 0,
      rank: json['rank'] ?? 0,
      refferalCount: json['referralCount'] ?? 0,
      tottalUserCount: json['totalCount'] ?? 0,
      totalUnseenNotifications: json['totalUnseenNotifications'] ?? 0
    );
  }
}
