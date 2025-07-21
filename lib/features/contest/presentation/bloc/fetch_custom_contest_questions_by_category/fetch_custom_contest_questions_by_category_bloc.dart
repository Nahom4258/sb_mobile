import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'fetch_custom_contest_questions_by_category_event.dart';
part 'fetch_custom_contest_questions_by_category_state.dart';

class FetchCustomContestQuestionsByCategoryBloc extends Bloc<FetchCustomContestQuestionsByCategoryEvent, FetchCustomContestQuestionsByCategoryState> {
  FetchCustomContestQuestionsByCategoryBloc({
        required this.fetchCustomContestQuestionsByCategoryUsecase,
  }) : super(FetchCustomContestQuestionsByCategoryInitial()) {
    on<FetchCustomContestQuestionsByCategoryEvent>((event, emit) async {
      emit(FetchCustomContestQuestionsByCategoryLoading());
      final failureOrSuccess = await fetchCustomContestQuestionsByCategoryUsecase(FetchCustomContestQuestionsByCategoryParams(categoryId: event.categoryId));
      emit(
        failureOrSuccess.fold(
            (failure) => FetchCustomContestQuestionsByCategoryFailed(failure: failure),
            (contestQuestions) => FetchCustomContestQuestionsByCategoryLoaded(contestQuestions: contestQuestions),
        ),
      );
    });
  }
  
  final FetchCustomContestQuestionsByCategoryUsecase fetchCustomContestQuestionsByCategoryUsecase;
}
