import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class FetchCustomContestInvitationsUsecase extends UseCase<List<CustomContest>, NoParams> {
  FetchCustomContestInvitationsUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, List<CustomContest>>> call(NoParams params) async {
    return await repository.fetchCustomContestInvitations();
  }
}
