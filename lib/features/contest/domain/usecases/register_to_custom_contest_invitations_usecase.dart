import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class RegisterToCustomContestInvitesUsecase
    extends UseCase<Unit, RegisterToCustomContestInvitesParams> {

  RegisterToCustomContestInvitesUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, Unit>> call(
      RegisterToCustomContestInvitesParams params) async {
    return await repository.registerToCustomContestInvitation(
        params.customContestId);
  }
}

class RegisterToCustomContestInvitesParams extends Equatable {
  const RegisterToCustomContestInvitesParams({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
