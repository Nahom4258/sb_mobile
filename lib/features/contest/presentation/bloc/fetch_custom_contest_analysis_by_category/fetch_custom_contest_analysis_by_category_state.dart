part of 'fetch_custom_contest_analysis_by_category_bloc.dart';

class FetchCustomContestAnalysisByCategoryState extends Equatable {
  const FetchCustomContestAnalysisByCategoryState();

  @override
  List<Object?> get props => [];
}

class FetchCustomContestAnalysisByCategoryInitial extends FetchCustomContestAnalysisByCategoryState {}

class FetchCustomContestAnalysisByCategoryLoading
    extends FetchCustomContestAnalysisByCategoryState {}

class FetchCustomContestAnalysisByCategoryLoaded
    extends FetchCustomContestAnalysisByCategoryState {
  const FetchCustomContestAnalysisByCategoryLoaded({
    required this.contestQuestions,
  });

  final List<ContestQuestion> contestQuestions;

  @override
  List<Object> get props => [contestQuestions];
}

class FetchCustomContestAnalysisByCategoryFailed
    extends FetchCustomContestAnalysisByCategoryState {
  final Failure failure;

  const FetchCustomContestAnalysisByCategoryFailed({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
