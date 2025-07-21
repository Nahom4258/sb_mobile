import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/usecase/usecase.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/recieve_friend_request_usecase.dart';

class SendFriendRequestUsecase
    extends UseCase<void, SendOrRecieveFriendRequestParams> {
  final FriendsRepositories friendsRepo;

  SendFriendRequestUsecase({required this.friendsRepo});
  @override
  Future<Either<Failure, void>> call(
      SendOrRecieveFriendRequestParams params) async {
    return await friendsRepo.sendFriendRequest(userId: params.userId);
  }
}
