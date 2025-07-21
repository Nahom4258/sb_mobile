part of 'fetch_registered_friends_for_custom_contest_bloc.dart';

class FetchRegisteredFriendsForCustomContestEvent extends Equatable {
  const FetchRegisteredFriendsForCustomContestEvent({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
