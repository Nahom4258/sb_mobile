import 'package:skill_bridge_mobile/core/utils/date_time_convert.dart';
import 'package:skill_bridge_mobile/features/contest/domain/entities/contest_ranking.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';

class ContestRankingModel extends ContestRankEntity {
  const ContestRankingModel({
    required super.id,
    required super.contestId,
    required super.startsAt,
    required super.endsAt,
    required super.score,
    required super.type,
    required super.userId,
    required super.emailOrPhone,
    required super.firstName,
    required super.lastName,
    required super.department,
    required super.avatar,
    required super.rank,
  });
  factory ContestRankingModel.fromJson(Map<String, dynamic> json) {
    return ContestRankingModel(
      id: json['_id'] ?? '',
      contestId: json['contestId'] ?? '',
      startsAt: json['startedAt'] == null
          ? DateTime.now()
          : convertToLocal(DateTime.parse(json['startedAt'])),
      endsAt: json['finishedAt'] == null
          ? DateTime.now()
          : convertToLocal(DateTime.parse(json['finishedAt'])),
      score: json['score'] ?? 0,
      type: json['type'] ?? "",
      userId: json['userId'] == null ? "" : json['userId']['_id'] ?? "",
      emailOrPhone:
          json['userId'] == null ? "" : json['userId']['email_phone'] ?? "",
      firstName:
          json['userId'] == null ? "" : json['userId']['firstName'] ?? "",
      lastName: json['userId'] == null ? "" : json['userId']['lastName'] ?? "",
      department:
          json['userId'] == null ? "" : json['userId']['department'] ?? '',
      avatar: json['userId'] == null
          ? ""
          : json['userId']['avatar'] ?? defaultProfileAvatar,
      rank: json['rank'] ?? 0,
    );
  }

  factory ContestRankingModel.fromCustomContestJson(Map<String, dynamic> json) {
    return ContestRankingModel(
      id: json['_id'] ?? '',
      contestId: json['customContestId'] ?? '',
      startsAt: json['startedAt'] == null
          ? DateTime.now()
          : convertToLocal(DateTime.parse(json['startedAt'])),
      endsAt: json['finishedAt'] == null
          ? DateTime.now()
          : convertToLocal(DateTime.parse(json['finishedAt'])),
      score: json['score'] ?? 0,
      type: json['type'] ?? "",
      userId: json['userId'] == null ? "" : json['userId']['_id'] ?? "",
      emailOrPhone:
          json['userId'] == null ? "" : json['userId']['email_phone'] ?? "",
      firstName:
          json['userId'] == null ? "" : json['userId']['firstName'] ?? "",
      lastName: json['userId'] == null ? "" : json['userId']['lastName'] ?? "",
      department:
          json['userId'] == null ? "" : json['userId']['department'] ?? '',
      avatar: json['userId'] == null
          ? ""
          : json['userId']['avatar'] ?? defaultProfileAvatar,
      rank: json['rank'] ?? 0,
    );
  }
}