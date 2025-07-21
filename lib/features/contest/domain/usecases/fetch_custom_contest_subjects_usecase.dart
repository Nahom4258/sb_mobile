import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';

class FetchCustomContestSubjectsUsecase
    extends UseCase<List<String>, NoParams> {
  final ContestRepository contestRepository;

  FetchCustomContestSubjectsUsecase({required this.contestRepository});
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await contestRepository.fetchCustomContestSubjects();
  }
}