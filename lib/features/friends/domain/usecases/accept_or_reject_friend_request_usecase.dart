import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/usecase/usecase.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';

class AcceptOrRejectFriendRequestUsecase
    extends UseCase<void, AcceptOrRejectParams> {
  final FriendsRepositories friendsRepo;

  AcceptOrRejectFriendRequestUsecase({required this.friendsRepo});
  @override
  Future<Either<Failure, void>> call(AcceptOrRejectParams params) async {
    return await friendsRepo.acceptOrRejectRequest(
        requestId: params.requestId, accept: params.acceptRequest);
  }
}

class AcceptOrRejectParams {
  final String requestId;
  final bool acceptRequest;

  AcceptOrRejectParams({required this.requestId, required this.acceptRequest});
}
