import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/exeption_to_failure_map.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/network/network.dart';
import 'package:skill_bridge_mobile/features/friends/data/datasources/friends_remote_datasource.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_search_entity.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';

class FriendsRepositoryImpl implements FriendsRepositories {
  final FriendsRemoteDataSource friendsRemoteDataSource;
  final NetworkInfo networkInfo;

  FriendsRepositoryImpl(
      {required this.friendsRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<FriendEntity>>> getAllFriends() async {
    if (await networkInfo.isConnected) {
      try {
        final friends = await friendsRemoteDataSource.getFriends();
        return Right(friends);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, FriendsSearchEntity>> searchFriends(
      {required String searchKey, required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final users = await friendsRemoteDataSource.searchFriends(
            page: page, searchText: searchKey);
        return Right(users);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<FriendEntity>>> getRecivedRequests() async {
    if (await networkInfo.isConnected) {
      try {
        final users = await friendsRemoteDataSource.getRecivedRequests();
        return Right(users);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<FriendEntity>>> getSentRequests() async {
    if (await networkInfo.isConnected) {
      try {
        final users = await friendsRemoteDataSource.getSentRequests();
        return Right(users);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> reciveFriendsRequest(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        await friendsRemoteDataSource.recieveFriendRequest(userId: userId);
        return const Right(Void);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        await friendsRemoteDataSource.sendFriendRequest(userId: userId);
        return const Right(Void);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> withdrawRequest(
      {required String requestId, required bool isForUnfriend}) async {
    if (await networkInfo.isConnected) {
      try {
        await friendsRemoteDataSource.withdrawFriendRequest(
            requestId: requestId, isForUnfriend: isForUnfriend);
        return const Right(Void);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> acceptOrRejectRequest(
      {required String requestId, required bool accept}) async {
    if (await networkInfo.isConnected) {
      try {
        await friendsRemoteDataSource.acceptOrRejectRequest(
            requestId: requestId, acceptRequest: accept);
        return const Right(Void);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
