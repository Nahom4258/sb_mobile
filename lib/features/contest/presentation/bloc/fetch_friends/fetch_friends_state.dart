part of 'fetch_friends_bloc.dart';

enum FetchFriendsEnum {initial, success, failure}

class FetchFriendsState extends Equatable {
  const FetchFriendsState({
    this.status = FetchFriendsEnum.initial,
    this.friends = const <Friend>[],
    this.fetchedFriends = const <Friend>[],
    this.hasReachedMax = false,
    this.failure,
  });

  final FetchFriendsEnum status;
  final List<Friend> friends;
  final List<Friend> fetchedFriends;
  final bool hasReachedMax;
  final Failure? failure;

  FetchFriendsState copyWith({
    FetchFriendsEnum? status,
    List<Friend>? friends,
    List<Friend>? fetchedFriends,
    bool? hasReachedMax,
    Failure? failure,
  }) {
    return FetchFriendsState(
      status: status ?? this.status,
      friends: friends ?? this.friends,
      fetchedFriends: fetchedFriends ?? this.fetchedFriends,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failure: failure ?? this.failure
    );
  }

  @override
  List<Object?> get props => [status, friends, fetchedFriends, hasReachedMax, failure];
}