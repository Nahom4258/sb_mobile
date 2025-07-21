import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class ClearLiveContestUsecase
    extends UseCase<Unit, NoParams> {
  final ContestRepository contestRepository;

  ClearLiveContestUsecase({required this.contestRepository});
  @override
  Future<Either<Failure, Unit>> call(
      NoParams params) async {
    return await contestRepository.clearLiveContest();
  }
}