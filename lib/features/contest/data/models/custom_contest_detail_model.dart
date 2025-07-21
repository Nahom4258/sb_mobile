import 'package:skill_bridge_mobile/core/utils/date_time_convert.dart';

import '../../../features.dart';

class CustomContestDetailModel extends CustomContestDetail {
  const CustomContestDetailModel({
    required super.customContestId,
    required super.title,
    required super.description,
    required super.isUpcoming,
    required super.hasRegistered,
    required super.hasEnded,
    required super.contestType,
    required super.userScore,
    required super.timeLeft,
    required super.startsAt,
    required super.endsAt,
    required super.isLive,
    required super.userRank,
    required super.isOwner,
    required super.customContestCategories,
  });

  factory CustomContestDetailModel.fromJson(Map<String, dynamic> json) {
    return CustomContestDetailModel(
      customContestId: json['generalInfo']['_id'] ?? '',
      title: json['generalInfo']['title'] ?? '',
      description: json['generalInfo']['description'] ?? '',
      isUpcoming: json['generalInfo']['isUpcoming'] ?? false,
      hasRegistered: json['generalInfo']['hasRegistered'] ?? false,
      hasEnded: json['generalInfo']['hasEnded'] ?? false,
      contestType: json['generalInfo']['contestType'] ?? '',
      userScore: json['generalInfo']['userScore'] ?? 0,
      timeLeft: (json['generalInfo']['timeLeft']).toDouble() ?? 0,
      startsAt: json['generalInfo']['countDown']['startsAt'] == null ?
        DateTime.now() :
        convertToLocal(DateTime.parse(json['generalInfo']['countDown']['startsAt'])),
      endsAt: json['generalInfo']['countDown']['finishAt'] == null ?
        DateTime.now() :
        convertToLocal(DateTime.parse(json['generalInfo']['countDown']['finishAt'])),
      isLive: json['generalInfo']['isLive'] ?? false,
      userRank: json['generalInfo']['userRank'] ?? 0,
      isOwner: json['generalInfo']['isOwner'] ?? false,
      customContestCategories: (json['customContestCategories'] ?? []).map<CustomContestCategoryModel>(
            (customContestCategory) => CustomContestCategoryModel.fromJson(customContestCategory),
      ).toList(),
    );
  }
}