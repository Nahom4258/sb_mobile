part of 'live_contest_bloc.dart';

class LiveContestEvent extends Equatable {
  const LiveContestEvent();

  @override
  List<Object> get props => [];
}

class CacheLiveContestEvent extends LiveContestEvent {
  const CacheLiveContestEvent({
    required this.contest,
  });

  final Contest contest;

  @override
  List<Object> get props => [contest];
}

class GetLiveContestEvent extends LiveContestEvent {}

class ClearLiveContestEvent extends LiveContestEvent {}
