import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class FetchCustomContestDetailUsecase extends UseCase<CustomContestDetail, FetchCustomContestDetailParams> {
  FetchCustomContestDetailUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, CustomContestDetail>> call(FetchCustomContestDetailParams params) async {
    return await repository.getCustomContestDetail(params.customContestId);
  }
}

class FetchCustomContestDetailParams extends Equatable {
  const FetchCustomContestDetailParams({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}