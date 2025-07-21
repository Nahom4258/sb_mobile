part of 'friends_bloc.dart';

class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsLoadedState extends FriendsState {
  final List<FriendEntity> friends;

  const FriendsLoadedState({required this.friends});
  @override
  List<Object> get props => [
        friends,
      ];
}

class FriendsLoadingState extends FriendsState {}

class FriendsLoadingFailedState extends FriendsState {}
