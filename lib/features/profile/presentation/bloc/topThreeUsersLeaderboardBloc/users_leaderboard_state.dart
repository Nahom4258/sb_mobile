part of 'users_leaderboard_bloc.dart';

class TopThreeUsersState extends Equatable {
  const TopThreeUsersState();

  @override
  List<Object> get props => [];
}

class TopThreeUsersInitial extends TopThreeUsersState {}

class TopThreeUsersLoadingState extends TopThreeUsersState {}

class TopThreeUsersLoadedState extends TopThreeUsersState {
  final Leaderboard topUsers;

  const TopThreeUsersLoadedState({
    required this.topUsers,
  });
  @override
  List<Object> get props => [topUsers];
}

class TopThreeUsersFailedState extends TopThreeUsersState {
  final String errorMessage;
  final Failure failure;

  const TopThreeUsersFailedState({
    required this.errorMessage,
    required this.failure,
  });
}
