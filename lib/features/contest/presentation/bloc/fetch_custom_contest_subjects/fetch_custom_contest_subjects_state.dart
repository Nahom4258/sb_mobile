part of 'fetch_custom_contest_subjects_bloc.dart';

class FetchCustomContestSubjectsState extends Equatable {
  const FetchCustomContestSubjectsState();

  @override
  List<Object?> get props => [];
}

class FetchCustomContestSubjectsInitial extends FetchCustomContestSubjectsState {}
class FetchCustomContestSubjectsLoading extends FetchCustomContestSubjectsState {}
class FetchCustomContestSubjectsLoaded extends FetchCustomContestSubjectsState {
  const FetchCustomContestSubjectsLoaded({required this.customContestSubjects});

  final List<String> customContestSubjects;

  @override
  List<Object?> get props => [customContestSubjects];
}
class FetchCustomContestSubjectsFailed extends FetchCustomContestSubjectsState {
  const FetchCustomContestSubjectsFailed({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
