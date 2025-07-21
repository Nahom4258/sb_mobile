part of 'search_friends_bloc.dart';

class SearchFriendsState extends Equatable {
  const SearchFriendsState();

  @override
  List<Object> get props => [];
}

class SearchFriendsInitial extends SearchFriendsState {}

class SearchFriendsLoadedState extends SearchFriendsState {
  final FriendsSearchEntity users;

  const SearchFriendsLoadedState({required this.users});
  @override
  List<Object> get props => [
        users,
      ];
}

class SearchFriendsLoadingState extends SearchFriendsState {}

class SearchPaginatedFriendsLoadingState extends SearchFriendsState {
  final FriendsSearchEntity users;

  const SearchPaginatedFriendsLoadingState({required this.users});
  @override
  List<Object> get props => [
        users,
      ];
}

class SearchFriendsFailedState extends SearchFriendsState {
  final Failure failure;

  const SearchFriendsFailedState({required this.failure});
}
