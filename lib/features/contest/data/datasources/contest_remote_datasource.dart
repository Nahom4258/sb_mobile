import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skill_bridge_mobile/core/constants/app_keys.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/data/models/freinds_model.dart';

import '../../../features.dart';

abstract class ContestRemoteDatasource {
  Future<List<ContestModel>> fetchPreviousContests();
  Future<ContestModel> fetchContestById({
    required String contestId,
  });
  Future<List<ContestModel>> fetchPreviousUserContests();
  Future<ContestModel?> fetchUpcomingUserContest();
  Future<ContestModel> registerToContest(String contestId, String? refferalId);
  Future<ContestDetail> getContestDetail(String contestId);
  Future<List<ContestQuestionModel>> fetchContestQuestionByCategory({
    required String categoryId,
  });
  Future<void> submitUserContestAnswer(ContestUserAnswer contestUserAnswer, bool isCustomContest);
  Future<ContestRankModel> getContestRanking(String contestId);
  Future<List<ContestQuestionModel>> fetchContestAnalysisByCategory({
    required String categoryId,
  });
  Future<List<LiveContestModel>> fetchLiveContests();
  Future<void> createCustomContest(String title, String description,
      DateTime startsAt, DateTime endsAt, Map<String, dynamic> questions);
  Future<List<String>> fetchCustomContestSubjects();
  Future<List<CustomContest>> fetchPreviousCustomContests();
  Future<List<CustomContest>> fetchUpcomingCustomContests();
  Future<CustomContestDetail> getCustomContestDetail(String customContestId);
  Future<void> updateCustomContest(String id, String title, String description,
      DateTime startsAt, DateTime endsAt, Map<String, dynamic> questions);
  Future<void> deleteCustomContest(String customContestId);
  Future<List<ContestQuestionModel>> fetchCustomContestQuestionsByCategory({required String categoryId});
  Future<List<CustomContestModel>> fetchCustomContestInvitations();
  Future<void> registerToCustomContestInvitation(String customContestId);
  Future<List<ContestQuestionModel>> fetchCustomContestAnalysisByCategory({
    required String categoryId,
  });
  Future<List<FriendsModel>> fetchRegisteredFriends({
    required String customContestId,
  });
  Future<void> sendInvitesForCustomContest({
    required String contestId,
    required List<String> friendsList,
  });
  Future<ContestRankModel> fetchCustomContestRanking({
    required String customContestId,
  });
  Future<List<FriendModel>> fetchFriends({
    required String customContestId,
    required int pageNumber,
    required int limit,
  });
}

class ContestRemoteDatasourceImpl extends ContestRemoteDatasource {
  ContestRemoteDatasourceImpl({
    required this.client,
    required this.flutterSecureStorage,
    required this.contestLocalDatasource,
  });

  // final http.Client client;
  final InterceptedClient client;
  final FlutterSecureStorage flutterSecureStorage;
  final ContestLocalDatasource contestLocalDatasource;

  @override
  Future<List<ContestModel>> fetchPreviousContests() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/contest/previousContests'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await contestLocalDatasource.cachePreviousContests(response.body);
        final data = json.decode(response.body)['data']['contests'];
        if (data == null) {
          return [];
        }
        return data
            .map<ContestModel>(
              (contest) => ContestModel.fromJson(contest),
            )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContestModel> fetchContestById({required String contestId}) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/contest/$contestId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['contest'];
        return ContestModel.fromJson(data);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ContestModel>> fetchPreviousUserContests() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/contest/userContest/userPreviousContests'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await contestLocalDatasource.cachePreviousUserContests(response.body);
        final data = json.decode(response.body)['data']['contests'];
        return data
            .map<ContestModel>(
              (contest) => ContestModel.fromJson(contest),
            )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContestModel?> fetchUpcomingUserContest() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/contest/userContest/upcomingContest'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['contest'];
        if (data == null) {
          return null;
        }
        return ContestModel.fromJson(data);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContestModel> registerToContest(
      String contestId, String? refferalId) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      Map<String, dynamic> contestIdPayload = {
        'contestId': contestId,
        'referredBy': refferalId
      };

      final response = await client.post(
        Uri.parse('$baseUrl/contest/userContest'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: json.encode(contestIdPayload),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body)['data']['newUserContest'];
        return ContestModel.fromJson(data);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContestDetail> getContestDetail(String contestId) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/contest/contestDetail/$contestId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await contestLocalDatasource.cacheContestDetail(
            contestId, response.body);
        final res = json.decode(response.body);
        Map<String, dynamic> data = res['data'];
        return ContestDetailModel.fromJson(data);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        print(response.body);
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContestRankModel> getContestRanking(String contestId) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/contest/contestRank/$contestId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        Map<String, dynamic> data = res['data'];
        return ContestRankModel.fromJson(data);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ContestQuestionModel>> fetchContestQuestionByCategory({
    required String categoryId,
  }) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse(
            '$baseUrl/contest/contestCategory/categoryQuestions/$categoryId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['questions'];
        return data
            .map<ContestQuestionModel>(
              (contestQuestion) =>
                  ContestQuestionModel.fromJson(contestQuestion),
            )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> submitUserContestAnswer(
      ContestUserAnswer contestUserAnswer, bool isCustomContest) async {
    try {
      final userCredentialString =
          await flutterSecureStorage.read(key: authenticationKey);

      if (userCredentialString == null) {
        throw UnauthorizedRequestException();
      }

      final userCredentialJson = json.decode(userCredentialString);
      final token = userCredentialJson['token'];

      final payload = json.encode(
        {
          'contestCategory': contestUserAnswer.contestCategoryId,
          'userAnswer': contestUserAnswer.userAnswers
              .map(
                (userAnswer) => {
                  'contestQuestionId': userAnswer.contestQuestionId,
                  'userAnswer': userAnswer.userAnswer
                          .substring(0, userAnswer.userAnswer.length - 1) +
                      userAnswer.userAnswer
                          .substring(userAnswer.userAnswer.length - 1)
                          .toUpperCase(),
                },
              )
              .toList(),
        },
      );

      final response = await client.post(
        Uri.parse( isCustomContest
            ? '$baseUrl/customContest/submitCategoryAnswer'
            : '$baseUrl/contest/contestCategory/submitAnswer'
        ),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ContestQuestionModel>> fetchContestAnalysisByCategory({
    required String categoryId,
  }) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse(
            '$baseUrl/contest/contestCategory/categoryAnalysis/$categoryId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['questions'];
        return data
            .map<ContestQuestionModel>(
              (contestQuestion) =>
                  ContestQuestionModel.fromAnalysisJson(contestQuestion),
            )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LiveContestModel>> fetchLiveContests() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/contest/userContest/userLiveContests'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return data
            .map<LiveContestModel>(
              (liveContest) => LiveContestModel.fromJson(liveContest),
            )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createCustomContest(
    String title,
    String description,
    DateTime startsAt,
    DateTime endsAt,
    Map<String, dynamic> questions,
  ) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    final payload = json.encode({
      "title": title,
      "description": description,
      "startsAt": startsAt.toIso8601String(),
      "endsAt": endsAt.toIso8601String(),
      "questions": questions,
    });

    try {
      final response = await client.post(
        Uri.parse('$baseUrl/customContest/createContest'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: payload,
      );

      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> fetchCustomContestSubjects() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/customContest/getContestSubjects'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return data.map<String>((subject) => subject.toString()).toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CustomContest>> fetchPreviousCustomContests() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/customContest/getPreviousCustomContests'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['contests'];
        return data
            .map<CustomContestModel>(
              (customContest) => CustomContestModel.fromJson(customContest),
        )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CustomContest>> fetchUpcomingCustomContests() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/customContest/getUpcomingCustomContests'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['contests'];
        return data
            .map<CustomContestModel>(
              (customContest) => CustomContestModel.fromJson(customContest),
        )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CustomContestDetail> getCustomContestDetail(String customContestId) async {
    final userCredentialString =
    await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/customContest/getCustomContestDetails/$customContestId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        Map<String, dynamic> data = res['data'];
        return CustomContestDetailModel.fromJson(data);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCustomContest(
      String id,
      String title,
      String description,
      DateTime startsAt,
      DateTime endsAt,
      Map<String, dynamic> questions,
      ) async {
    final userCredentialString =
    await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    final payload = json.encode({
      "title": title,
      "description": description,
      "startsAt": startsAt.toIso8601String(),
      "endsAt": endsAt.toIso8601String(),
      "questions": questions,
    });

    try {
      final response = await client.put(
        Uri.parse('$baseUrl/customContest/updateCustomContest/$id'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCustomContest(String customContestId) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/customContest/deleteCustomContest/$customContestId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ContestQuestionModel>> fetchCustomContestQuestionsByCategory({required String categoryId}) async {
    final userCredentialString =
    await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse(
            '$baseUrl/customContest/getCategoryQuestions/$categoryId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['questions'];
        return data
            .map<ContestQuestionModel>(
              (contestQuestion) =>
              ContestQuestionModel.fromCustomContestJson(contestQuestion),
        )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CustomContestModel>> fetchCustomContestInvitations() async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/customContest/invite'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['contests'];
        return data
            .map<CustomContestModel>(
              (customContest) => CustomContestModel.fromJson(customContest),
        )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerToCustomContestInvitation(String customContestId) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      Map<String, dynamic> contestIdPayload = {
        'customContestId': customContestId,
      };

      final response = await client.post(
        Uri.parse('$baseUrl/customContest/registerToCustomContest'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: json.encode(contestIdPayload),
      );

      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ContestQuestionModel>> fetchCustomContestAnalysisByCategory({required String categoryId})  async {
    final userCredentialString =
    await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse(
            '$baseUrl/customContest/getCategoryAnalysis/$categoryId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['questions'];
        return data
            .map<ContestQuestionModel>(
              (contestQuestion) =>
              ContestQuestionModel.fromAnalysisJson(contestQuestion),
        )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FriendsModel>> fetchRegisteredFriends({required String customContestId}) async {
    final userCredentialString =
    await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse(
            '$baseUrl/customContest/getRegisteredUsers/$customContestId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return data
            .map<FriendsModel>(
              (friends) =>
              FriendsModel.fromCustomContestJson(friends),
        )
            .toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendInvitesForCustomContest({
    required String contestId,
    required List<String> friendsList,
  }) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];

    final payload = {
      "contestId": contestId,
      "userIds": friendsList,
    };

    try {
      final response = await client.post(
        Uri.parse('$baseUrl/customContest/invite'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContestRankModel> fetchCustomContestRanking({required String customContestId}) async {
    final userCredentialString =
    await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/customContest/getCustomContestRanking/$customContestId'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        Map<String, dynamic> data = res['data'];
        return ContestRankModel.fromCustomContestJson(data);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FriendModel>> fetchFriends({
    required String customContestId,
    required int pageNumber,
    required int limit,
  }) async {
    final userCredentialString =
        await flutterSecureStorage.read(key: authenticationKey);

    if (userCredentialString == null) {
      throw UnauthorizedRequestException();
    }

    final userCredentialJson = json.decode(userCredentialString);
    final token = userCredentialJson['token'];
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/customContest/invite/friends/$customContestId?page=$pageNumber&limit=$limit'),
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final friendsList = res['data']['friendsList'];
        return friendsList.map<FriendModel>(
                (friend) => FriendModel.fromJson(friend)
              ).toList();
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
