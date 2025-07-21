part of 'contest_submit_user_answer_bloc.dart';

class ContestSubmitUserAnswerEvent extends Equatable {
  const ContestSubmitUserAnswerEvent({
    required this.contestUserAnswer,
    this.isCustomContest = false,
  });

  final ContestUserAnswer contestUserAnswer;
  final bool isCustomContest;

  @override
  List<Object> get props => [contestUserAnswer, isCustomContest];
}
