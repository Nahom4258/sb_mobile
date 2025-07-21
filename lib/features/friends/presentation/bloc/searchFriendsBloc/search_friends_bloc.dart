import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_search_entity.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/search_friends_usecase.dart';

part 'search_friends_event.dart';
part 'search_friends_state.dart';

class SearchFriendsBloc extends Bloc<SearchFriendsEvent, SearchFriendsState> {
  final SearchFriendsUsecase searchFriendsUsecase;
  SearchFriendsBloc({required this.searchFriendsUsecase})
      : super(SearchFriendsInitial()) {
    on<SearchFriendsEvent>((event, emit) async {
      int pageNum = 1;
      if (state is SearchFriendsLoadedState && event.nextPage) {
        final curusers = (state as SearchFriendsLoadedState).users;
        if (curusers.currentPage == curusers.numberOfPages) {
          return; // do not load if it is the last index
        }
        // emit(SearchPaginatedFriendsLoadingState(
        //   users: curusers,
        // ));
        pageNum = curusers.currentPage + 1;
      } else {
        emit(SearchFriendsLoadingState());
      }

      final failureOrUsers = await searchFriendsUsecase(
          FriendsSearchParams(searckKey: event.searchKey, page: pageNum));

      final searchState = failureOrUsers.fold(
        (l) => SearchFriendsFailedState(failure: l),
        (r) {
          if (event.nextPage && state is SearchFriendsLoadedState) {
            final oldUsers = (state as SearchFriendsLoadedState).users.friends;
            final updatedUsers = [...oldUsers, ...r.friends];
            final updatedSearchEntity = FriendsSearchEntity(
              friends: updatedUsers,
              numberOfPages: r.numberOfPages,
              currentPage: r.currentPage,
            );
            return SearchFriendsLoadedState(users: updatedSearchEntity);
          } else {
            return SearchFriendsLoadedState(users: r);
          }
        },
      );

      emit(searchState);
    });
  }
}
