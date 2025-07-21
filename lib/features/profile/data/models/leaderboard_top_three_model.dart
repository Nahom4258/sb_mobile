import 'package:skill_bridge_mobile/features/profile/domain/entities/leaderboard.dart';

import '../../../features.dart';
import 'user_leaderboard_model.dart';

class LeaderboardTopThreeModel extends Leaderboard {
  const LeaderboardTopThreeModel({
    required super.userLeaderboardEntities,
    required super.userRank,
    required super.numberofPages,
    required super.currentPage,
  });

  factory LeaderboardTopThreeModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardTopThreeModel(
      userLeaderboardEntities: (json['topUsers'] ?? [])
          .map<UserLeaderboardModel>(
            (leaderboard) => UserLeaderboardModel.fromJson(leaderboard),
          )
          .toList(),
      userRank: json['userRank'] == null
          ? null
          : UserLeaderboardRankModel.fromJson(json['userRank']),
      numberofPages: json['totalPages'] ?? 1,
      currentPage: 1,
    );
  }
}
