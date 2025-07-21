part of 'users_leaderboard_bloc.dart';

class TopThreeUsersEvent extends Equatable {
  const TopThreeUsersEvent();

  @override
  List<Object> get props => [];
}

class GetTopThreeUsersEvent extends TopThreeUsersEvent {
  final int pageNumber;
  final LeaderboardType leaderboardType;

  const GetTopThreeUsersEvent({
    required this.pageNumber,
    required this.leaderboardType,
  });
}
