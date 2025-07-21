part of 'live_contest_bloc.dart';

class LiveContestState extends Equatable {
  const LiveContestState();

  @override
  List<Object?> get props => [];
}

class LiveContestInitial extends LiveContestState {}

class CacheLiveContestLoading extends LiveContestState {}

class CacheLiveContestLoaded extends LiveContestState {}

class CacheLiveContestFailed extends LiveContestState {}

class GetLiveContestLoading extends LiveContestState {}

class GetLiveContestLoaded extends LiveContestState {
  const GetLiveContestLoaded({
    required this.contest,
  });

  final Contest? contest;

  @override
  List<Object?> get props => [contest];
}

class GetLiveContestFailed extends LiveContestState {}

class ClearLiveContestLoading extends LiveContestState {}

class ClearLiveContestLoaded extends LiveContestState {}

class ClearLiveContestFailed extends LiveContestState {}
