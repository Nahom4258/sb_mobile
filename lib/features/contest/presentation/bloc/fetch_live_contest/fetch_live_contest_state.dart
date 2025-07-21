part of 'fetch_live_contest_bloc.dart';

abstract class FetchLiveContestState extends Equatable {
  const FetchLiveContestState();

  @override
  List<Object> get props => [];
}

class FetchLiveContestInitial extends FetchLiveContestState {}

class FetchLiveContestLoading extends FetchLiveContestState {}

class FetchLiveContestLoaded extends FetchLiveContestState {
  const FetchLiveContestLoaded({required this.liveContests,});

  final List<LiveContest> liveContests;

  @override
  List<Object> get props => [liveContests];
}

class FetchLiveContestFailed extends FetchLiveContestState {
  const FetchLiveContestFailed({required this.failure,});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}

