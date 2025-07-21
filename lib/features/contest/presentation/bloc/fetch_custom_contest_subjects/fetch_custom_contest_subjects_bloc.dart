import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/core/error/error.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';

part 'fetch_custom_contest_subjects_event.dart';
part 'fetch_custom_contest_subjects_state.dart';

class FetchCustomContestSubjectsBloc extends Bloc<FetchCustomContestSubjectsEvent, FetchCustomContestSubjectsState> {
  FetchCustomContestSubjectsBloc({
    required this.fetchCustomContestSubjectsUsecase,
  }) : super(FetchCustomContestSubjectsInitial()) {
    on<FetchCustomContestSubjectsEvent>((event, emit) async {
      emit(FetchCustomContestSubjectsLoading());
      final failureOrSuccess = await fetchCustomContestSubjectsUsecase(NoParams());
      emit(
        failureOrSuccess.fold(
                (failure) => FetchCustomContestSubjectsFailed(failure: failure),
                (customContestSubjects) => FetchCustomContestSubjectsLoaded(customContestSubjects: customContestSubjects)
        ),
      );
    });
  }

  final FetchCustomContestSubjectsUsecase fetchCustomContestSubjectsUsecase;
}
