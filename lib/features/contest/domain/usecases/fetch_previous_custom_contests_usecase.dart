import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class FetchPreviousCustomContestsUsecase extends UseCase<List<CustomContest>, NoParams> {
  FetchPreviousCustomContestsUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, List<CustomContest>>> call(NoParams params) async {
    return await repository.fetchPreviousCustomContests();
  }
}
