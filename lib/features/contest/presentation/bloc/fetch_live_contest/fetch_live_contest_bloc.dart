import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_live_contest_event.dart';
part 'fetch_live_contest_state.dart';

class FetchLiveContestBloc
    extends Bloc<FetchLiveContestEvent, FetchLiveContestState> {
  FetchLiveContestBloc({
    required this.fetchLiveContestsUsecase,
  }) : super(FetchLiveContestInitial()) {
    on<FetchingLiveContestEvent>((event, emit) async {
      emit(FetchLiveContestLoading());
      final failureOrSuccess = await fetchLiveContestsUsecase(NoParams());
      emit(failureOrSuccess.fold(
        (failure) => FetchLiveContestFailed(failure: failure),
        (liveContests) => FetchLiveContestLoaded(liveContests: liveContests),
      ));
    });
  }

  final FetchLiveContestsUsecase fetchLiveContestsUsecase;
}
