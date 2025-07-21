import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';
import '../../../friends/data/models/freinds_model.dart';

abstract class ContestRepository {
  Future<Either<Failure, List<Contest>>> fetchPreviousContests();
  Future<Either<Failure, Contest>> fetchContestById({
    required String contestId,
  });
  Future<Either<Failure, List<Contest>>> fetchPreviousUserContests();
  Future<Either<Failure, ContestModel?>> fetchUpcomingUserContest();
  Future<Either<Failure, Contest>> registerUserToContest(
      String contestId, String? refferalId);
  Future<Either<Failure, ContestDetail>> getContestDetail(String contestId);
  Future<Either<Failure, ContestRank>> getContestRanking(String contestId);
  Future<Either<Failure, List<ContestQuestion>>>
      fetchContestQuestionsByCategory({
    required String categoryId,
  });
  Future<Either<Failure, void>> submitUserContestAnswer(
    ContestUserAnswer contestUserAnswer,
      bool isCustomContest,
  );
  Future<Either<Failure, List<ContestQuestion>>>
      fetchContestAnalysisByCategory({
    required String categoryId,
  });
  Future<Either<Failure, List<LiveContest>>> fetchLiveContests();
  Future<Either<Failure, Unit>> cacheLiveContest(Contest contest);
  Future<Either<Failure, Contest?>> getLiveContest();
  Future<Either<Failure, Unit>> clearLiveContest();
  Future<Either<Failure, Unit>> createCustomContest({
    required CreateCustomContestParams params,
  });

  Future<Either<Failure, List<String>>> fetchCustomContestSubjects();
  Future<Either<Failure, List<CustomContest>>> fetchPreviousCustomContests();
  Future<Either<Failure, List<CustomContest>>> fetchUpcomingCustomContests();
  Future<Either<Failure, CustomContestDetail>> getCustomContestDetail(
      String customContestId);
  Future<Either<Failure, Unit>> updateCustomContest({
    required UpdateCustomContestParams params,
  });
  Future<Either<Failure, Unit>> deleteCustomContest({
    required String customContestId,
  });
  Future<Either<Failure, List<ContestQuestionModel>>> fetchCustomContestQuestionsByCategory({
    required String categoryId,
  });

  Future<Either<Failure, List<CustomContest>>> fetchCustomContestInvitations();
  Future<Either<Failure, Unit>> registerToCustomContestInvitation(String customContestId);
  Future<Either<Failure, List<ContestQuestion>>> fetchCustomContestAnalysisByCategory({required String categoryId});
  Future<Either<Failure, List<FriendsModel>>> fetchRegisteredFriends({required String customContestId});
  Future<Either<Failure, Unit>> sendInvitesForCustomContest({
    required String contestId,
    required List<String> friendsList,
  });
  Future<Either<Failure, ContestRankModel>> fetchCustomContestRanking({
    required String customContestId,
  });
  Future<Either<Failure, List<Friend>>> fetchFriends({
    required String customContestId,
    required int pageNumber,
    required int limit,
  });
}
