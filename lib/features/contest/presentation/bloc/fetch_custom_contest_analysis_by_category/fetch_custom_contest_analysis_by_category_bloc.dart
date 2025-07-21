import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_custom_contest_analysis_by_category_event.dart';
part 'fetch_custom_contest_analysis_by_category_state.dart';

class FetchCustomContestAnalysisByCategoryBloc extends Bloc<FetchCustomContestAnalysisByCategoryEvent, FetchCustomContestAnalysisByCategoryState> {
  FetchCustomContestAnalysisByCategoryBloc({
    required this.fetchCustomContestAnalysisByCategoryUsecase,
}) : super(FetchCustomContestAnalysisByCategoryInitial()) {
    on<FetchCustomContestAnalysisByCategoryEvent>((event, emit) async {
      emit(FetchCustomContestAnalysisByCategoryLoading());
      final failureOrSuccess = await fetchCustomContestAnalysisByCategoryUsecase(FetchCustomContestAnalysisByCategoryParams(categoryId: event.categoryId));
      emit(
        failureOrSuccess.fold(
            (failure) => FetchCustomContestAnalysisByCategoryFailed(failure: failure),
            (contestQuestions) => FetchCustomContestAnalysisByCategoryLoaded(contestQuestions: contestQuestions),
        )
      );
    });
  }

  final FetchCustomContestAnalysisByCategoryUsecase fetchCustomContestAnalysisByCategoryUsecase;
}
