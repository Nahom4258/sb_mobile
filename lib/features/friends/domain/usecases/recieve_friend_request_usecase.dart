import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/usecase/usecase.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';

class RecieveFriendRequestUsecase
    extends UseCase<void, SendOrRecieveFriendRequestParams> {
  final FriendsRepositories friendsRepo;

  RecieveFriendRequestUsecase({required this.friendsRepo});
  @override
  Future<Either<Failure, void>> call(
      SendOrRecieveFriendRequestParams params) async {
    return await friendsRepo.reciveFriendsRequest(userId: params.userId);
  }
}

class SendOrRecieveFriendRequestParams {
  final String userId;

  SendOrRecieveFriendRequestParams({required this.userId});
}
