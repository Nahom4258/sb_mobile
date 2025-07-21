import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import '../../../features.dart';

import '../../../../core/constants/app_keys.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/school_entity.dart';

abstract class OnboardingQuestionsRemoteDataSource {
  Future<UserCredentialModel> submitOnboardingQuestions(
      OnboardingQuestionsResponse userResponse);

  Future<List<SchoolEntity>> getSchools(String param);
}

class OnboardingQuestionsRemoteDataSourceImpl
    implements OnboardingQuestionsRemoteDataSource {
  // final http.Client client;
  final InterceptedClient client;

  final FlutterSecureStorage flutterSecureStorage;

  OnboardingQuestionsRemoteDataSourceImpl({
    required this.client,
    required this.flutterSecureStorage,
  });

  @override
  Future<UserCredentialModel> submitOnboardingQuestions(
      OnboardingQuestionsResponse userResponse) async {
    final userModel = await flutterSecureStorage.read(key: authenticationKey);

    if (userModel == null) {
      throw UnauthorizedRequestException();
    }

    final userModelJson = json.decode(userModel);
    final token = userModelJson['token'];

    final payload = json.encode(
      OnboardingQuestionsModel(
        challengingSubjects: userResponse.challengingSubjects,
        // howPrepared: userResponse.howPrepared,
        id: userResponse.id,
        // motivation: userResponse.motivation,
        // preferedMethod: userResponse.preferedMethod,
        // reminderTime: userResponse.reminderTime,
        // studyTimePerday: userResponse.studyTimePerday,s
        school: userResponse.school,
        region: userResponse.region,
        grade: userResponse.grade
      ).toJson(),
    );

    try {
      final response = await client.put(
        Uri.parse('$baseUrl/user/updateProfile'),
        headers: {
          'content-Type': 'application/json',
          'authorization': 'Bearer $token'
        },
        body: payload,
      );
      log(payload);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];

        UserCredentialModel userCredtial =
            UserCredentialModel.fromUpdatedUserJson(data);

        return userCredtial;
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

   @override
  Future<List<SchoolEntity>> getSchools(String param) async {
    // Example implementation to retrieve school data from a remote API
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/school?search=$param'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> schoolsJson = json.decode(response.body)['data'];
        return schoolsJson.map((json) => SchoolEntity.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error fetching schools: $e');
      throw ServerException();
    }
  }
}
