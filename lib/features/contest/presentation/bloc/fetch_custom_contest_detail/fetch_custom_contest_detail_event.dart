part of 'fetch_custom_contest_detail_bloc.dart';

class FetchCustomContestDetailEvent extends Equatable {
  const FetchCustomContestDetailEvent({
    required this.customContestId,
});

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
