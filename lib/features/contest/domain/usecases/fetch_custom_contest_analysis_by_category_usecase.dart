import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class FetchCustomContestAnalysisByCategoryUsecase extends UseCase<
    List<ContestQuestion>, FetchCustomContestAnalysisByCategoryParams> {
  FetchCustomContestAnalysisByCategoryUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, List<ContestQuestion>>> call(
      FetchCustomContestAnalysisByCategoryParams params) async {
    return await repository.fetchCustomContestAnalysisByCategory(
      categoryId: params.categoryId,
    );
  }
}

class FetchCustomContestAnalysisByCategoryParams extends Equatable {
  const FetchCustomContestAnalysisByCategoryParams({
    required this.categoryId,
  });

  final String categoryId;

  @override
  List<Object?> get props => [categoryId];
}
