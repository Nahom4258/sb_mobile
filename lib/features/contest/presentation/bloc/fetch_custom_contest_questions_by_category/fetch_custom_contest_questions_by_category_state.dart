part of 'fetch_custom_contest_questions_by_category_bloc.dart';

class FetchCustomContestQuestionsByCategoryState extends Equatable {
  const FetchCustomContestQuestionsByCategoryState();

  @override
  List<Object?> get props => [];
}

class FetchCustomContestQuestionsByCategoryInitial extends FetchCustomContestQuestionsByCategoryState {}

class FetchCustomContestQuestionsByCategoryLoading
    extends FetchCustomContestQuestionsByCategoryState {}

class FetchCustomContestQuestionsByCategoryLoaded
    extends FetchCustomContestQuestionsByCategoryState {
  final List<ContestQuestion> contestQuestions;

  const FetchCustomContestQuestionsByCategoryLoaded({
    required this.contestQuestions,
  });

  @override
  List<Object> get props => [contestQuestions];
}

class FetchCustomContestQuestionsByCategoryFailed
    extends FetchCustomContestQuestionsByCategoryState {
  final Failure failure;

  const FetchCustomContestQuestionsByCategoryFailed({
    required this.failure,
  });


// @override
// List<Object> get props => [errorMessage];
}