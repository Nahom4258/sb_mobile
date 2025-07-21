part of 'fetch_previous_custom_contest_bloc.dart';

class FetchPreviousCustomContestState extends Equatable {
  const FetchPreviousCustomContestState();

  @override
  List<Object?> get props => [];
}

class FetchPreviousCustomContestInitial extends FetchPreviousCustomContestState {}

class FetchPreviousCustomContestLoading extends FetchPreviousCustomContestState {}

class FetchPreviousCustomContestLoaded extends FetchPreviousCustomContestState {
  const FetchPreviousCustomContestLoaded({required this.previousCustomContests});

  final List<CustomContest> previousCustomContests;

  @override
  List<Object?> get props => [previousCustomContests];
}

class FetchPreviousCustomContestFailed extends FetchPreviousCustomContestState {
  const FetchPreviousCustomContestFailed({required this.failure});

  final Failure failure;
  @override
  List<Object?> get props => [failure];
}
