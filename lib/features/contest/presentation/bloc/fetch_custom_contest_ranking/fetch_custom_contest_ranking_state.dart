part of 'fetch_custom_contest_ranking_bloc.dart';

class FetchCustomContestRankingState extends Equatable {
  const FetchCustomContestRankingState();

  @override
  List<Object?> get props => [];
}

class FetchCustomContestRankingInitial extends FetchCustomContestRankingState {}
class FetchCustomContestRankingLoading extends FetchCustomContestRankingState {}
class FetchCustomContestRankingLoaded extends FetchCustomContestRankingState {
  const FetchCustomContestRankingLoaded({
    required this.contestRank,
  });

  final ContestRank contestRank;

  @override
  List<Object?> get props => [contestRank];
}

class FetchCustomContestRankingFailed extends FetchCustomContestRankingState {
  const FetchCustomContestRankingFailed({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
