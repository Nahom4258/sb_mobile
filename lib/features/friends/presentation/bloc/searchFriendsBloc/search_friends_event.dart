part of 'search_friends_bloc.dart';

class SearchFriendsEvent extends Equatable {
  final String searchKey;
  final bool nextPage;
  const SearchFriendsEvent({required this.searchKey, required this.nextPage});

  @override
  List<Object> get props => [
        searchKey,
        nextPage,
      ];
}
