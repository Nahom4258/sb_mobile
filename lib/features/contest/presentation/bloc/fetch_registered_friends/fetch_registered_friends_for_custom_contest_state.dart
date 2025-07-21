part of 'fetch_registered_friends_for_custom_contest_bloc.dart';

class FetchRegisteredFriendsForCustomContestState extends Equatable {
  const FetchRegisteredFriendsForCustomContestState();

  @override
  List<Object?> get props => [];
}

class FetchRegisteredFriendsForCustomContestInitial extends FetchRegisteredFriendsForCustomContestState {}

class FetchRegisteredFriendsForCustomContestLoading extends FetchRegisteredFriendsForCustomContestState {}

class FetchRegisteredFriendsForCustomContestLoaded extends FetchRegisteredFriendsForCustomContestState {

  const FetchRegisteredFriendsForCustomContestLoaded({
    required this.friends,
  });

  final List<FriendEntity> friends;

  @override
  List<Object?> get props => [friends];
}

class FetchRegisteredFriendsForCustomContestFailed extends FetchRegisteredFriendsForCustomContestState {
  const FetchRegisteredFriendsForCustomContestFailed({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}


