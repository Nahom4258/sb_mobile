import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_friends_event.dart';
part 'fetch_friends_state.dart';

class FetchFriendsBloc extends Bloc<FetchFriendsEvent, FetchFriendsState> {
  FetchFriendsBloc({
    required this.fetchFriendsUsecase,
  }) : super(const FetchFriendsState()) {
    on<FetchPaginatedFriendsEvent>((event, emit) async {
      if (state.hasReachedMax) return;

      if (state.status == FetchFriendsEnum.initial) {
        final failureOrSuccess = await fetchFriendsUsecase(
            FetchFriendsParams(
              customContestId: event.customContestId,
              pageNumber: pageNumber,
              limit: limit,
            )
        );

        emit(
          failureOrSuccess.fold(
                  (failure) =>
                  state.copyWith(
                    status: FetchFriendsEnum.failure,
                    failure: failure,
                  ),
                  (friends) {
                    if(friends.isEmpty) {
                      return state.copyWith(status: FetchFriendsEnum.success, hasReachedMax: true);
                    }

                    pageNumber += 1;
                    return state.copyWith(
                      status: FetchFriendsEnum.success,
                      friends: List.of(state.friends)
                    ..addAll(friends),
                      fetchedFriends: List.of(state.fetchedFriends)
                        ..addAll(friends),
                );
              }
          ),
        );
      }
    });
    on<FetchSearchedFriendsFromPaginatedFriendsEvent>((event, emit) {
      emit(state.copyWith(status: FetchFriendsEnum.initial));
      if(event.searchTerm == '') {
        emit(state.copyWith(status: FetchFriendsEnum.success, friends: state.fetchedFriends));
      }
      else {
        final filteredFriends = state.fetchedFriends
            .where(
              (friend) {
                final firstName = friend.firstName.toLowerCase();
                final lastName = friend.lastName.toLowerCase();
                final searchTerm = event.searchTerm.toLowerCase();
                return firstName.contains(searchTerm) ||
                  lastName.contains(searchTerm);
              }
            )
            .toList();
        emit(state.copyWith(
            status: FetchFriendsEnum.success, friends: filteredFriends));
      }
    });
    on<ReFetchPaginatedFriendsEvent>((event, emit) {
      pageNumber = 1;
      emit(state.copyWith(hasReachedMax: false, friends: [], fetchedFriends: [], status: FetchFriendsEnum.initial));
      add(FetchPaginatedFriendsEvent(customContestId: event.customContestId));
    });
  }

  final FetchFriendsUsecase fetchFriendsUsecase;
  int pageNumber = 1;
  final int limit = 10;
}
