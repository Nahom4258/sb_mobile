import 'package:equatable/equatable.dart';
import '../../../features.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_leaderboard_entity.dart';

class Leaderboard extends Equatable {
  final List<UserLeaderboardEntity> userLeaderboardEntities;
  final UserLeaderboardRank? userRank;
  final int numberofPages;
  final int currentPage;
  const Leaderboard({
    required this.userLeaderboardEntities,
    required this.userRank,
    required this.numberofPages,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [
        userLeaderboardEntities,
        userRank,
        currentPage,
      ];
}
