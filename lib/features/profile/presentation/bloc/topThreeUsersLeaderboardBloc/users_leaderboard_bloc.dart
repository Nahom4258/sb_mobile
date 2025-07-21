import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_leaderboard_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_top_users_usecase.dart';

import '../../../../features.dart';

part 'users_leaderboard_event.dart';
part 'users_leaderboard_state.dart';

class TopThreeUsersBloc extends Bloc<TopThreeUsersEvent, TopThreeUsersState> {
  final GetTopUsersUsecase getTopUsersUsecase;
  TopThreeUsersBloc({
    required this.getTopUsersUsecase,
  }) : super(TopThreeUsersInitial()) {
    on<GetTopThreeUsersEvent>(onGetTopUsersEvent);
  }
  onGetTopUsersEvent(
      GetTopThreeUsersEvent event, Emitter<TopThreeUsersState> emit) async {
    emit(TopThreeUsersLoadingState());
    final response = await getTopUsersUsecase(
      LeaderboardParams(
        page: event.pageNumber,
        leaderboardType: event.leaderboardType,
        isForTopThree: true,
      ),
    );
    final state = response.fold(
      (failure) => TopThreeUsersFailedState(
          errorMessage: failure.errorMessage, failure: failure),
      (leaderboard) => TopThreeUsersLoadedState(topUsers: leaderboard),
    );
    emit(state);
  }
}
