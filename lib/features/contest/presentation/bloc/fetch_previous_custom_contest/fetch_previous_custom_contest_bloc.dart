import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_previous_custom_contest_event.dart';
part 'fetch_previous_custom_contest_state.dart';

class FetchPreviousCustomContestBloc extends Bloc<FetchPreviousCustomContestEvent, FetchPreviousCustomContestState> {
  FetchPreviousCustomContestBloc({
    required this.fetchPreviousCustomContestsUsecase,
}) : super(FetchPreviousCustomContestInitial()) {
    on<FetchPreviousCustomContestEvent>((event, emit) async {
      emit(FetchPreviousCustomContestLoading());
      final failureOrSuccess = await fetchPreviousCustomContestsUsecase(NoParams());
      emit(failureOrSuccess.fold(
          (failure) => FetchPreviousCustomContestFailed(failure: failure),
          (previousCustomContests) => FetchPreviousCustomContestLoaded(previousCustomContests: previousCustomContests),
      ));
    });
  }

  final FetchPreviousCustomContestsUsecase fetchPreviousCustomContestsUsecase;
}
