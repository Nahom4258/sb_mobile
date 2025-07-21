part of 'fetch_upcoming_custom_contest_bloc.dart';

class FetchUpcomingCustomContestState extends Equatable {
  const FetchUpcomingCustomContestState();

  @override
  List<Object?> get props => [];
}

class FetchUpcomingCustomContestInitial extends FetchUpcomingCustomContestState {}

class FetchUpcomingCustomContestLoading extends FetchUpcomingCustomContestState {}

class FetchUpcomingCustomContestLoaded extends FetchUpcomingCustomContestState {
  const FetchUpcomingCustomContestLoaded({required this.upcomingCustomContests});

  final List<CustomContest> upcomingCustomContests;

  @override
  List<Object?> get props => [upcomingCustomContests];
}

class FetchUpcomingCustomContestFailed extends FetchUpcomingCustomContestState {
  const FetchUpcomingCustomContestFailed({required this.failure});

  final Failure failure;
  @override
  List<Object?> get props => [failure];
}

