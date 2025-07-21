import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class SubmitContestUserAnswerUsecase extends UseCase<void, SubmitContestUserAnswerParams> {
  SubmitContestUserAnswerUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, void>> call(SubmitContestUserAnswerParams params) async {
    return await repository.submitUserContestAnswer(params.contestUserAnswer, params.isCustomContest);
  }
}

class SubmitContestUserAnswerParams extends Equatable {
  const SubmitContestUserAnswerParams({
    required this.contestUserAnswer,
    required this.isCustomContest,
  });

  final bool isCustomContest;
  final ContestUserAnswer contestUserAnswer;

  @override
  List<Object?> get props => [isCustomContest, contestUserAnswer];
}
