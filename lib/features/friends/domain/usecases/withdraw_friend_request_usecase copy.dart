import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/usecase/usecase.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';
import 'package:skill_bridge_mobile/features/friends/domain/usecases/recieve_friend_request_usecase.dart';

class WithdrawFriendRequestUsecase
    extends UseCase<void, WithdrawFriendRequestParams> {
  final FriendsRepositories friendsRepo;

  WithdrawFriendRequestUsecase({required this.friendsRepo});
  @override
  Future<Either<Failure, void>> call(WithdrawFriendRequestParams params) async {
    return await friendsRepo.withdrawRequest(
        requestId: params.userId, isForUnfriend: params.isForunfriend);
  }
}

class WithdrawFriendRequestParams {
  final String userId;
  final bool isForunfriend;

  WithdrawFriendRequestParams(
      {required this.userId, required this.isForunfriend});
}
