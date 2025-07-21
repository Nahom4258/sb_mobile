part of 'fetch_live_contest_bloc.dart';


abstract class FetchLiveContestEvent extends Equatable {
  const FetchLiveContestEvent();

  @override
  List<Object> get props => [];
}

class FetchingLiveContestEvent extends FetchLiveContestEvent {}
