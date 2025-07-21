import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class FetchLiveContestsUsecase extends UseCase<
    List<LiveContest>, NoParams> {
  FetchLiveContestsUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, List<LiveContest>>> call(
      NoParams params) async {
    return await repository.fetchLiveContests(
    );
  }
}
