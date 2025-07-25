import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/user_leaderboard_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/usecases/get_top_users_usecase.dart';

import '../../../../features.dart';

part 'users_leaderboard_event.dart';
part 'users_leaderboard_state.dart';

class UsersLeaderboardBloc
    extends Bloc<UsersLeaderboardEvent, UsersLeaderboardState> {
  final GetTopUsersUsecase getTopUsersUsecase;
  UsersLeaderboardBloc({
    required this.getTopUsersUsecase,
  }) : super(UsersLeaderboardInitial()) {
    on<GetTopUsersEvent>(onGetTopUsersEvent);
  }
  onGetTopUsersEvent(
      GetTopUsersEvent event, Emitter<UsersLeaderboardState> emit) async {
    emit(UsersLeaderboardLoadingState());
    final response = await getTopUsersUsecase(
      LeaderboardParams(
          page: event.pageNumber,
          leaderboardType: event.leaderboardType,
          isForTopThree: false),
    );
    final state = response.fold(
      (failure) => UsersLeaderboardFailedState(
          errorMessage: failure.errorMessage, failure: failure),
      (leaderboard) => UsersLeaderboardLoadedState(topUsers: leaderboard),
    );
    emit(state);
  }
  // onGetTopUsersEvent(
  //     GetTopUsersEvent event, Emitter<UsersLeaderboardState> emit) async {
  //   if (event.pageNumber == 1) {
  //     emit(UsersLeaderboardLoadingState());
  //   } else {
  //     emit(
  //       UsersLeaderboardNextPageLoadingState(
  //           previousLeaderboard:
  //               (state as UsersLeaderboardLoadedState).topUsers),
  //     );
  //   }
  //   final response = await getTopUsersUsecase(LeaderboardParams(
  //       page: event.pageNumber, leaderboardType: event.leaderboardType));

  //   List<UserLeaderboardEntity> leaderBoardEntities = [];
  //   if (event.pageNumber > 1) {
  //     if (state is UsersLeaderboardNextPageLoadingState) {
  //       leaderBoardEntities.addAll(
  //           (state as UsersLeaderboardNextPageLoadingState)
  //               .previousLeaderboard
  //               .userLeaderboardEntities);
  //     }

  //     final newState = response.fold(
  //       (l) => UsersLeaderboardLoadedState(
  //           topUsers: (state as UsersLeaderboardLoadedState).topUsers),
  //       (r) {
  //         leaderBoardEntities.addAll(r.userLeaderboardEntities);
  //         UserLeaderboardRank? userInfo = r.userRank;
  //         return UsersLeaderboardLoadedState(
  //           topUsers: Leaderboard(
  //             userLeaderboardEntities: leaderBoardEntities,
  //             userRank: userInfo,
  //           ),
  //         );
  //       },
  //     );

  //     emit(newState);
  //   } else {
  //     final newState = response.fold(
  //       (l) => UsersLeaderboardFailedState(
  //           errorMessage: l.errorMessage, failure: l),
  //       (r) {
  //         return UsersLeaderboardLoadedState(topUsers: r);
  //       },
  //     );
  //     emit(newState);
  //   }
  // }
}
