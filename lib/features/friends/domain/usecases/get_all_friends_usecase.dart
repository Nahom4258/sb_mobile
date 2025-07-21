import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/error/failure.dart';
import 'package:skill_bridge_mobile/core/usecase/usecase.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';

class GetAllFriendsUsecase extends UseCase<List<FriendEntity>, NoParams> {
  final FriendsRepositories friendsRepo;

  GetAllFriendsUsecase({required this.friendsRepo});
  @override
  Future<Either<Failure, List<FriendEntity>>> call(NoParams params) async {
    return await friendsRepo.getAllFriends();
  }
}
