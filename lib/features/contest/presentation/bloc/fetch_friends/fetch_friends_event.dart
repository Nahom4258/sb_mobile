part of 'fetch_friends_bloc.dart';



abstract class FetchFriendsEvent extends Equatable {
  const FetchFriendsEvent();

  @override
  List<Object?> get props => [];
}


class FetchPaginatedFriendsEvent extends FetchFriendsEvent {
  const FetchPaginatedFriendsEvent({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}

class FetchSearchedFriendsFromPaginatedFriendsEvent extends FetchFriendsEvent {
  const FetchSearchedFriendsFromPaginatedFriendsEvent({
    required this.searchTerm,
  });

  final String searchTerm;

  @override
  List<Object?> get props => [searchTerm];
}

class ReFetchPaginatedFriendsEvent extends FetchFriendsEvent {
  const ReFetchPaginatedFriendsEvent({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}

