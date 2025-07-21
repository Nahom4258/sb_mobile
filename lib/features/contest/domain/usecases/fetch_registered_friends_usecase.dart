import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class FetchRegisteredFriendsUsecase
    extends UseCase<List<FriendEntity>, FetchRegisteredFriendsParams> {
  FetchRegisteredFriendsUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, List<FriendEntity>>> call(
      FetchRegisteredFriendsParams params) async {

    return await repository.fetchRegisteredFriends(
        customContestId: params.customContestId,
    );
  }
}

class FetchRegisteredFriendsParams extends Equatable{
  const FetchRegisteredFriendsParams({
    required this.customContestId,
  });

  final String customContestId;

  @override
  List<Object?> get props => [customContestId];
}
