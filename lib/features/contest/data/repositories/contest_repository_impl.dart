import 'package:dartz/dartz.dart';
import 'package:skill_bridge_mobile/core/utils/date_time_convert.dart';
import 'package:skill_bridge_mobile/features/contest/domain/entities/contest_detail.dart';
import 'package:skill_bridge_mobile/features/friends/data/models/freinds_model.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class ContestRepositoryImpl extends ContestRepository {
  ContestRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });

  final ContestLocalDatasource localDatasource;
  final ContestRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Contest>>> fetchPreviousContests() async {
    try {
      if (await networkInfo.isConnected) {
        final contests = await remoteDatasource.fetchPreviousContests();
        return Right(contests);
      } else {
        final contests = await localDatasource.getPreviousContests();

        if (contests != null) {
          return Right(contests);
        } else {
          return Left(NetworkFailure());
        }
      }
    } catch (e) {
      return Left(await mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Contest>> fetchContestById(
      {required String contestId}) async {
    if (await networkInfo.isConnected) {
      try {
        final contest =
            await remoteDatasource.fetchContestById(contestId: contestId);
        return Right(contest);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<Contest>>> fetchPreviousUserContests() async {
    try {
      if (await networkInfo.isConnected) {
        final contests = await remoteDatasource.fetchPreviousUserContests();
        return Right(contests);
      } else {
        final contests = await localDatasource.getPreviousUserContests();

        if (contests != null) {
          return Right(contests);
        } else {
          return Left(NetworkFailure());
        }
      }
    } catch (e) {
      return Left(await mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ContestModel?>> fetchUpcomingUserContest() async {
    if (await networkInfo.isConnected) {
      try {
        final contest = await remoteDatasource.fetchUpcomingUserContest();
        return Right(contest);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Contest>> registerUserToContest(
      String contestId, String? refferalId) async {
    if (await networkInfo.isConnected) {
      try {
        final contest =
            await remoteDatasource.registerToContest(contestId, refferalId);
        return Right(contest);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, ContestDetail>> getContestDetail(
      String contestId) async {
    try {
      if (await networkInfo.isConnected) {
        final contestDetail =
            await remoteDatasource.getContestDetail(contestId);
        return Right(contestDetail);
      } else {
        final contestDetail = await localDatasource.getContestDetail(contestId);

        if (contestDetail != null) {
          return Right(contestDetail);
        }
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(await mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ContestRank>> getContestRanking(
      String contestId) async {
    if (await networkInfo.isConnected) {
      try {
        final contestDetail =
            await remoteDatasource.getContestRanking(contestId);
        return Right(contestDetail);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<ContestQuestion>>>
      fetchContestQuestionsByCategory({
    required String categoryId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final contestQuestions =
            await remoteDatasource.fetchContestQuestionByCategory(
          categoryId: categoryId,
        );
        return Right(contestQuestions);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> submitUserContestAnswer(
      ContestUserAnswer contestUserAnswer, bool isCustomContest) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDatasource.submitUserContestAnswer(contestUserAnswer, isCustomContest);
        return const Right(unit);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<ContestQuestion>>> fetchContestAnalysisByCategory(
      {required String categoryId}) async {
    if (await networkInfo.isConnected) {
      try {
        final contestQuestions =
            await remoteDatasource.fetchContestAnalysisByCategory(
          categoryId: categoryId,
        );
        return Right(contestQuestions);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<LiveContest>>> fetchLiveContests() async {
    if (await networkInfo.isConnected) {
      try {
        final liveContests = await remoteDatasource.fetchLiveContests();
        return Right(liveContests);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> cacheLiveContest(Contest contest) async {
    try {
      await localDatasource.cacheLiveContest(contest);
      return const Right(unit);
    } catch (e) {
      return Left(await mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearLiveContest() async {
    try {
      await localDatasource.clearLiveContest();
      return const Right(unit);
    } catch (e) {
      return Left(await mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Contest?>> getLiveContest() async {
    try {
      final contest = await localDatasource.getLiveContest();
      return Right(contest);
    } catch (e) {
      return Left(await mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> createCustomContest({
    required CreateCustomContestParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDatasource.createCustomContest(
          params.title,
          params.description,
          convertToGMT(params.startsAt),
          convertToGMT(params.endsAt),
          params.questions,
        );
        return const Right(unit);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<String>>> fetchCustomContestSubjects() async {
    if (await networkInfo.isConnected) {
      try {
        final subjects = await remoteDatasource.fetchCustomContestSubjects(
        );
        return Right(subjects);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<CustomContest>>> fetchPreviousCustomContests() async {
    if (await networkInfo.isConnected) {
      try {
        final previousCustomContests = await remoteDatasource.fetchPreviousCustomContests();
        return Right(previousCustomContests);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
    }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<CustomContest>>> fetchUpcomingCustomContests() async {
    if (await networkInfo.isConnected) {
      try {
        final upcomingCustomContests = await remoteDatasource.fetchUpcomingCustomContests();
        return Right(upcomingCustomContests);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
    }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, CustomContestDetail>> getCustomContestDetail(
      String customContestId) async {
    try {
      if (await networkInfo.isConnected) {
        final customContestDetail =
        await remoteDatasource.getCustomContestDetail(customContestId);
        return Right(customContestDetail);
      }
    } catch (e) {
      return Left(await mapExceptionToFailure(e));
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> updateCustomContest({
    required UpdateCustomContestParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDatasource.updateCustomContest(
          params.id,
          params.title,
          params.description,
          params.startsAt,
          params.endsAt,
          params.questions,
        );
        return const Right(unit);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomContest({required String customContestId}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDatasource.deleteCustomContest(
          customContestId,
        );
        return const Right(unit);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
    }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<ContestQuestionModel>>> fetchCustomContestQuestionsByCategory({required String categoryId}) async {
    if (await networkInfo.isConnected) {
      try {
        final contestQuestions =
        await remoteDatasource.fetchCustomContestQuestionsByCategory(
          categoryId: categoryId,
        );
        return Right(contestQuestions);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<CustomContest>>> fetchCustomContestInvitations() async {
    if (await networkInfo.isConnected) {
      try {
        final customContestInvitations = await remoteDatasource.fetchCustomContestInvitations();
        return Right(customContestInvitations);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
    }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> registerToCustomContestInvitation(String customContestId) async {
    if (await networkInfo.isConnected) {
      try {
        final contest =
            await remoteDatasource.registerToCustomContestInvitation(customContestId);
        return const Right(unit);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
    }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<ContestQuestion>>> fetchCustomContestAnalysisByCategory({required String categoryId}) async {
    if (await networkInfo.isConnected) {
      try {
        final contestQuestions =
        await remoteDatasource.fetchCustomContestAnalysisByCategory(
          categoryId: categoryId,
        );
        return Right(contestQuestions);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<FriendsModel>>> fetchRegisteredFriends({required String customContestId}) async {
    if (await networkInfo.isConnected) {
      try {
        final friends=
        await remoteDatasource.fetchRegisteredFriends(
          customContestId: customContestId,
        );
        return Right(friends);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Unit>> sendInvitesForCustomContest({required String contestId, required List<String> friendsList}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDatasource.sendInvitesForCustomContest(
          contestId: contestId,
          friendsList: friendsList,
        );
        return const Right(unit);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, ContestRankModel>> fetchCustomContestRanking({
    required String customContestId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final customContestRanking =
        await remoteDatasource.fetchCustomContestRanking(customContestId: customContestId);
        return Right(customContestRanking);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<Friend>>> fetchFriends({
    required String customContestId,
    required int pageNumber,
    required int limit,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final friends =
        await remoteDatasource.fetchFriends(
          customContestId: customContestId,
          pageNumber: pageNumber,
          limit: limit,
        );
        return Right(friends);
      } catch (e) {
        return Left(await mapExceptionToFailure(e));
      }
    }
    return Left(NetworkFailure());
  }
}
