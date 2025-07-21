import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class CacheLiveContestUsecase
    extends UseCase<Unit, CacheLiveContestParams> {
  final ContestRepository contestRepository;

  CacheLiveContestUsecase({required this.contestRepository});
  @override
  Future<Either<Failure, Unit>> call(
      CacheLiveContestParams params) async {
    return await contestRepository.cacheLiveContest(params.contest);
  }
}

class CacheLiveContestParams extends Equatable{
  final Contest contest;

  CacheLiveContestParams({required this.contest,});

  @override
  List<Object?> get props => [contest];
}
