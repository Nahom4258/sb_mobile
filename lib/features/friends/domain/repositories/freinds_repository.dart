import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_search_entity.dart';

abstract class FriendsRepositories {
  Future<Either<Failure, List<FriendEntity>>> getAllFriends();
  Future<Either<Failure, List<FriendEntity>>> getSentRequests();
  Future<Either<Failure, List<FriendEntity>>> getRecivedRequests();
  Future<Either<Failure, FriendsSearchEntity>> searchFriends(
      {required String searchKey, required int page});
  Future<Either<Failure, void>> sendFriendRequest({required String userId});
  Future<Either<Failure, void>> reciveFriendsRequest({required String userId});
  Future<Either<Failure, void>> withdrawRequest(
      {required String requestId, required bool isForUnfriend});
  Future<Either<Failure, void>> acceptOrRejectRequest({
    required String requestId,
    required bool accept,
  });
}
