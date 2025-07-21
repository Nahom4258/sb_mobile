import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_registered_friends_for_custom_contest_event.dart';
part 'fetch_registered_friends_for_custom_contest_state.dart';

class FetchRegisteredFriendsForCustomContestBloc extends Bloc<FetchRegisteredFriendsForCustomContestEvent, FetchRegisteredFriendsForCustomContestState> {
  FetchRegisteredFriendsForCustomContestBloc({
    required this.fetchRegisteredFriendsUsecase,
  }) : super(FetchRegisteredFriendsForCustomContestInitial()) {
    on<FetchRegisteredFriendsForCustomContestEvent>((event, emit) async {
      emit(FetchRegisteredFriendsForCustomContestLoading());
      final failureOrSuccess = await fetchRegisteredFriendsUsecase(FetchRegisteredFriendsParams(customContestId: event.customContestId));
      emit(
        failureOrSuccess.fold(
              (failure) => FetchRegisteredFriendsForCustomContestFailed(failure: failure),
              (friends) => FetchRegisteredFriendsForCustomContestLoaded(friends: friends),
        ),
      );
    });
  }

  final FetchRegisteredFriendsUsecase fetchRegisteredFriendsUsecase;
}
