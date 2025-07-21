import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class FetchCustomContestQuestionsByCategoryUsecase extends UseCase<
    List<ContestQuestion>, FetchCustomContestQuestionsByCategoryParams> {
  FetchCustomContestQuestionsByCategoryUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, List<ContestQuestion>>> call(
      FetchCustomContestQuestionsByCategoryParams params) async {
    return await repository.fetchCustomContestQuestionsByCategory(
      categoryId: params.categoryId,
    );
  }
}

class FetchCustomContestQuestionsByCategoryParams extends Equatable {
  const FetchCustomContestQuestionsByCategoryParams({
    required this.categoryId,
  });

  final String categoryId;

  @override
  List<Object?> get props => [categoryId];
}
