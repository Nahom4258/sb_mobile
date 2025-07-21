import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';

class SendInvitesForCustomContestUsecase extends UseCase<void, SendInvitesForCustomContestParams> {
  SendInvitesForCustomContestUsecase({
    required this.repository,
  });

  final ContestRepository repository;


  @override
  Future<Either<Failure, void>> call(SendInvitesForCustomContestParams params) async {
    return await repository.sendInvitesForCustomContest(contestId: params.contestId, friendsList: params.friendsList);
  }

}

class SendInvitesForCustomContestParams extends Equatable {
  const SendInvitesForCustomContestParams({
    required this.contestId,
    required this.friendsList,
  });


  final String contestId;
  final List<String> friendsList;


  @override
  List<Object?> get props => [contestId, friendsList];

}