part of 'fetch_custom_contest_ranking_bloc.dart';

class FetchCustomContestRankingEvent extends Equatable {
  const FetchCustomContestRankingEvent({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
