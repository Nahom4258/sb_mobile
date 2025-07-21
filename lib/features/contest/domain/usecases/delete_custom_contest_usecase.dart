import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class DeleteCustomContestByIdUsecase extends UseCase<void, DeleteCustomContestByIdParams> {
  DeleteCustomContestByIdUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, void>> call(DeleteCustomContestByIdParams params) async {
    return await repository.deleteCustomContest(customContestId: params.customContestId);
  }
}

class DeleteCustomContestByIdParams extends Equatable {
  const DeleteCustomContestByIdParams({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
