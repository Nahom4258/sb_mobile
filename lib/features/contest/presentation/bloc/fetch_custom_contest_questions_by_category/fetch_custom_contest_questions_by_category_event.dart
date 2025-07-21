part of 'fetch_custom_contest_questions_by_category_bloc.dart';

class FetchCustomContestQuestionsByCategoryEvent extends Equatable {
  const FetchCustomContestQuestionsByCategoryEvent({
    required this.categoryId,
});

  final String categoryId;

  @override
  List<Object?> get props => [categoryId];
}
