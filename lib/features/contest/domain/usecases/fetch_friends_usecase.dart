import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import '';
import '../../../features.dart';

class FetchFriendsUsecase extends UseCase<List<Friend>, FetchFriendsParams> {
  FetchFriendsUsecase({
    required this.repository,
  });

  final ContestRepository repository;

  @override
  Future<Either<Failure, List<Friend>>> call(FetchFriendsParams params) async {
    return await repository.fetchFriends(
      customContestId: params.customContestId,
      pageNumber: params.pageNumber,
      limit: params.limit,
    );
  }
}

class FetchFriendsParams extends Equatable  {
  const FetchFriendsParams({
    required this.customContestId,
    required this.pageNumber,
    required this.limit,
  });

  final String customContestId;
  final int pageNumber;
  final int limit;

  @override
  List<Object?> get props => [customContestId, pageNumber, limit];

}