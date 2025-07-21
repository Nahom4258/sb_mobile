import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_entitiy.dart';
import 'package:skill_bridge_mobile/features/friends/domain/entities/friend_search_entity.dart';
import 'package:skill_bridge_mobile/features/friends/domain/repositories/freinds_repository.dart';

class SearchFriendsUsecase
    extends UseCase<FriendsSearchEntity, FriendsSearchParams> {
  final FriendsRepositories friendsRepo;

  SearchFriendsUsecase({required this.friendsRepo});
  @override
  Future<Either<Failure, FriendsSearchEntity>> call(
      FriendsSearchParams params) async {
    return await friendsRepo.searchFriends(
        searchKey: params.searckKey, page: params.page);
  }
}

class FriendsSearchParams {
  final String searckKey;
  final int page;

  FriendsSearchParams({required this.searckKey, required this.page});
}
