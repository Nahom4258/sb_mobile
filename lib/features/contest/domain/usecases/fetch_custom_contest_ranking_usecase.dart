import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class FetchCustomContestRankingUsecase extends UseCase<ContestRank, CustomContestRankingParams> {
  FetchCustomContestRankingUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, ContestRank>> call(CustomContestRankingParams params) async {
    return await repository.fetchCustomContestRanking(customContestId: params.customContestId);
  }
}

class CustomContestRankingParams extends Equatable{
  const CustomContestRankingParams({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
