import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';

import '../../../../../core/core.dart';

part 'fetch_custom_contest_ranking_event.dart';
part 'fetch_custom_contest_ranking_state.dart';

class FetchCustomContestRankingBloc extends Bloc<FetchCustomContestRankingEvent, FetchCustomContestRankingState> {
  FetchCustomContestRankingBloc({
    required this.fetchCustomContestRankingUsecase,
  }) : super(FetchCustomContestRankingInitial()) {
    on<FetchCustomContestRankingEvent>((event, emit) async {
      emit(FetchCustomContestRankingLoading());
      final failureOrSuccess = await fetchCustomContestRankingUsecase(CustomContestRankingParams(customContestId: event.customContestId));
      emit(
        failureOrSuccess.fold(
            (failure) => FetchCustomContestRankingFailed(failure: failure),
            (contestRank) => FetchCustomContestRankingLoaded(contestRank: contestRank),
        )
      );
    });
  }

  final FetchCustomContestRankingUsecase fetchCustomContestRankingUsecase;
}
