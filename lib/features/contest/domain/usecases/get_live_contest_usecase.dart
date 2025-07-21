import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class GetLiveContestUsecase
    extends UseCase<Contest?, NoParams> {
  final ContestRepository contestRepository;

  GetLiveContestUsecase({required this.contestRepository});
  @override
  Future<Either<Failure, Contest?>> call(
      NoParams params) async {
    return await contestRepository.getLiveContest();
  }
}
