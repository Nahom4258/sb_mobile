import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'live_contest_event.dart';
part 'live_contest_state.dart';

class LiveContestBloc extends Bloc<LiveContestEvent, LiveContestState> {
  LiveContestBloc({
    required this.cacheLiveContestUsecase,
    required this.clearLiveContestUsecase,
    required this.getLiveContestUsecase,
  }) : super(LiveContestInitial()) {
    on<CacheLiveContestEvent>((event, emit) async {
      emit(CacheLiveContestLoading());
      final successOrFailure = await cacheLiveContestUsecase(
        CacheLiveContestParams(
          contest: event.contest,
        ),
      );
      emit(
        successOrFailure.fold(
          (l) => CacheLiveContestFailed(),
          (r) => CacheLiveContestLoaded(),
        ),
      );
    });
    on<ClearLiveContestEvent>((event, emit) async {
      emit(ClearLiveContestLoading());
      final successOrFailure = await clearLiveContestUsecase(
        NoParams(),
      );
      emit(
        successOrFailure.fold(
          (l) => ClearLiveContestFailed(),
          (r) => ClearLiveContestLoaded(),
        ),
      );
    });
    on<GetLiveContestEvent>((event, emit) async {
      emit(GetLiveContestLoading());
      final successOrFailure = await getLiveContestUsecase(NoParams());
      emit(
        successOrFailure.fold(
          (l) => GetLiveContestFailed(),
          (contest) => GetLiveContestLoaded(
            contest: contest,
          ),
        ),
      );
    });
  }

  final CacheLiveContestUsecase cacheLiveContestUsecase;
  final ClearLiveContestUsecase clearLiveContestUsecase;
  final GetLiveContestUsecase getLiveContestUsecase;
}
