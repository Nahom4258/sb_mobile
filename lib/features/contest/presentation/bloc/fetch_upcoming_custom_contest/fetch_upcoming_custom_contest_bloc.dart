import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_upcoming_custom_contest_event.dart';
part 'fetch_upcoming_custom_contest_state.dart';

class FetchUpcomingCustomContestBloc extends Bloc<FetchUpcomingCustomContestEvent, FetchUpcomingCustomContestState> {
  FetchUpcomingCustomContestBloc({
    required this.fetchUpcomingCustomContestsUsecase,
  }) : super(FetchUpcomingCustomContestInitial()) {
    on<FetchUpcomingCustomContestEvent>((event, emit) async {
      emit(FetchUpcomingCustomContestLoading());
      final failureOrSuccess = await fetchUpcomingCustomContestsUsecase(NoParams());
      emit(
        failureOrSuccess.fold(
                (failure) => FetchUpcomingCustomContestFailed(failure: failure),
                (upcomingCustomContests) => FetchUpcomingCustomContestLoaded(upcomingCustomContests: upcomingCustomContests),
        )
      );
    });
  }

  final FetchUpcomingCustomContestsUsecase fetchUpcomingCustomContestsUsecase;
}
