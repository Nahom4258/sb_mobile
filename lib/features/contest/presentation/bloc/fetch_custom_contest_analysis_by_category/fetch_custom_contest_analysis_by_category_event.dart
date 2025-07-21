part of 'fetch_custom_contest_analysis_by_category_bloc.dart';

class FetchCustomContestAnalysisByCategoryEvent extends Equatable {
  const FetchCustomContestAnalysisByCategoryEvent({
    required this.categoryId,
  });

  final String categoryId;

  @override
  List<Object?> get props => [categoryId];
}
