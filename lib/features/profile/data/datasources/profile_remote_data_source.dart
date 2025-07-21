import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skill_bridge_mobile/core/constants/app_enums.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/all_barchart_categories_model.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/consistency_model.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/leaderboard_top_three_model.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/school_model.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/user_cashout_requests_model.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/user_profile_model.dart';
import 'package:skill_bridge_mobile/features/profile/data/models/user_referal_info_mode.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/consistency_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/profile_update_entity.dart';

import '../../../../core/constants/app_keys.dart';
import '../../../../core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class ProfileRemoteDataSource {
  Future<UserCredentialModel> postChangeUsername(
      String firstname, String lastname);
  Future<ChangePasswordModel> postChangePassword(
      String oldPassword, String newPassword, String repeatPassword);
  Future<UserProfileModel> getUserProfile({String? userId});
  Future<bool> logout();
  Future<bool> deleteAccount();
  Future<void> clearAuthenticationCredential();
  Future<UserCredentialModel> updateProfile(ProfileUpdateEntity updateEntity);
  Future<Leaderboard> getTopUsers({
    required int page,
    required LeaderboardType leaderboardType,
    required bool isForTopThree,
  });
  Future<List<ConsistencyEntity>> getConsistencyData(
      {required String year, String? userId});
  Future<SchoolDepartmentModel> getSchoolInfo();
  Future<ScoreCategoryListModel> getBarChartData();
  Future<UserRefferalInfoModel> getUserRefferalInfo();
  Future<UserCashoutRequestsModel> getUserCashoutRequests();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  // final http.Client client;
  final InterceptedClient client;
  final ProfileLocalDataSource profileLocalDataSource;
  final FlutterSecureStorage flutterSecureStorage;

  ProfileRemoteDataSourceImpl({
    required this.client,
    required this.flutterSecureStorage,
    required this.profileLocalDataSource,
  });

  @override
  Future<UserCredentialModel> updateProfile(
      ProfileUpdateEntity updateEntity) async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];

      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      };
      var url = Uri.parse('$baseUrl/user/updateProfile');
      var request = http.MultipartRequest('PUT', url);
      if (updateEntity.firstName != null) {
        request.fields['firstName'] = updateEntity.firstName!;
      }
      if (updateEntity.lastName != null) {
        request.fields['lastName'] = updateEntity.lastName!;
      }
      if (updateEntity.howPrepared != null) {
        request.fields['howPrepared'] = updateEntity.howPrepared!;
      }
      if (updateEntity.preferredMethod != null) {
        request.fields['preferredMethod'] = updateEntity.preferredMethod!;
      }
      if (updateEntity.studyTime != null) {
        request.fields['studyTimePerDay'] = updateEntity.studyTime!;
      }
      if (updateEntity.motivation != null) {
        request.fields['motivation'] = updateEntity.motivation!;
      }
      if (updateEntity.reminder != null) {
        request.fields['reminder'] = updateEntity.reminder!;
      }
      if (updateEntity.departmentId != null) {
        request.fields['department'] = updateEntity.departmentId!;
      }
      if (updateEntity.grade != null) {
        request.fields['grade'] = updateEntity.grade!.toString();
      }
      if (updateEntity.school != null) {
        request.fields['highSchool'] = updateEntity.school!;
      }
      if (updateEntity.imagePath != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
              contentType: MediaType(
                  'image', updateEntity.imagePath!.path.split(".").last),
              "avatar",
              File(updateEntity.imagePath!.path).readAsBytesSync(),
              filename: updateEntity.imagePath!.path),
        );
      }

      request.headers.addAll(headers);
      final response = await request.send();

      var res = await http.Response.fromStream(response);

      if (res.statusCode == 200) {
        var data = json.decode(res.body)['data'];

        UserCredentialModel updatedUserCredential =
            UserCredentialModel.fromUpdatedUserJson(data);
        return updatedUserCredential;
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  // get userProfile
  @override
  Future<UserProfileModel> getUserProfile({String? userId}) async {
    final userModel = await flutterSecureStorage.read(key: authenticationKey);

    if (userModel == null) {
      throw UnauthorizedRequestException();
    }

    final userModelJson = json.decode(userModel);
    final token = userModelJson['token'];

    try {
      late http.Response response;
      if (userId != null) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard/getUser/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        );
        print(response);
      } else {
        response = await client.get(
          Uri.parse('$baseUrl/user/currentUser'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        );
      }

      if (response.statusCode == 200) {
        if (userId == null) {
          await profileLocalDataSource.saveProfileData(response.body);
        }
        final profile = json.decode(response.body);
        return UserProfileModel.fromJson(profile['data']);
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  // change username
  @override
  Future<UserCredentialModel> postChangeUsername(
      String firstname, String lastname) async {
    final userModel = await flutterSecureStorage.read(key: authenticationKey);

    if (userModel == null) {
      throw UnauthorizedRequestException();
    }

    final userModelJson = json.decode(userModel);
    final token = userModelJson['token'];

    Map<String, String> requestBody = {
      'firstName': firstname,
      'lastName': lastname
    };

    String jsonBody = json.encode(requestBody);

    final response = await http.put(
      Uri.parse('$baseUrl/user/updateProfile'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body)['data'];
      return UserCredentialModel.fromUpdatedUserJson(responseJson);
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      throw AuthenticationException(
          errorMessage: 'Expired or invalid token used');
    } else if (response.statusCode == 429) {
      throw RequestOverloadException(errorMessage: 'Too Many Request');
    } else {
      throw ServerException();
    }
  }

  //change password
  @override
  Future<ChangePasswordModel> postChangePassword(
      String oldPassword, String newPassword, String repeatPassword) async {
    final userModel = await flutterSecureStorage.read(key: authenticationKey);
    try {
      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];

      Map<String, String> requestBody = {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': repeatPassword
      };

      String jsonBody = json.encode(requestBody);

      final response = await client.post(
        Uri.parse('$baseUrl/user/userChangePassword'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        return const ChangePasswordModel();
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
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
  Future<void> clearAuthenticationCredential() async {
    return await flutterSecureStorage.delete(key: authenticationKey);
  }

  @override
  Future<bool> logout() async {
    final userModel = await flutterSecureStorage.read(key: authenticationKey);

    if (userModel == null) {
      throw UnauthorizedRequestException();
    }

    final userModelJson = json.decode(userModel);
    final token = userModelJson['token'];
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/user/logout'),
        headers: {
          'content-Type': 'application/json',
          'authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 201) {
        await clearAuthenticationCredential();
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
  @override
  Future<bool> deleteAccount() async {
    final userModel = await flutterSecureStorage.read(key: authenticationKey);

    if (userModel == null) {
      throw UnauthorizedRequestException();
    }

    final userModelJson = json.decode(userModel);
    final token = userModelJson['token'];
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/user/deactivate'),
        headers: {
          'content-Type': 'application/json',
          'authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        await clearAuthenticationCredential();
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Leaderboard> getTopUsers(
      {required int page,
      required LeaderboardType leaderboardType,
      required bool isForTopThree}) async {
    final userModel = await flutterSecureStorage.read(key: authenticationKey);

    if (userModel == null) {
      throw UnauthorizedRequestException();
    }

    final userModelJson = json.decode(userModel);
    final token = userModelJson['token'];
    try {
      late Response response;
      if (leaderboardType == LeaderboardType.all_alltime) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      } else if (leaderboardType == LeaderboardType.all_weekly) {
        response = await client.get(
          Uri.parse('$baseUrl/user/weeklylLeaderboard?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      }
      else if (leaderboardType == LeaderboardType.all_monthly) {
        response = await client.get(
          Uri.parse('$baseUrl/user/monthlyLeaderboard?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      }
      else if (leaderboardType == LeaderboardType.friends_alltime) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard/friends?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      }
      else if (leaderboardType == LeaderboardType.friends_weekly) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard/friends/weekly?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      }
      else if (leaderboardType == LeaderboardType.friends_monthly) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard/friends/monthly?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      }
      else if (leaderboardType == LeaderboardType.school_monthly) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard/school/monthly?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      }
      else if (leaderboardType == LeaderboardType.school_weekly) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard/school/weekly?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      } else if (leaderboardType == LeaderboardType.school_alltime) {
        response = await client.get(
          Uri.parse('$baseUrl/user/leaderboard/school?page=$page&limit=10'),
          headers: {
            'content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
        );
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        if (isForTopThree) {
          return LeaderboardTopThreeModel.fromJson(data);
        }
        return LeaderboardModel.fromJson(data);
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
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
  Future<List<ConsistencyEntity>> getConsistencyData(
      {required String year, String? userId}) async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      late http.Response response;
      if (userId != null) {
        response = await client.get(
          Uri.parse(
              '$baseUrl/user/leaderboard/getUserStreak/$userId?year=$year'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        );
      } else {
        response = await client.get(
          Uri.parse('$baseUrl/user/userConsistencydata?year=$year'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        );
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        List<dynamic> consistencyData = data['consistencyData'];
        return consistencyData
            .map((data) => ConsistencyModel.fromJson(data))
            .toList();
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
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
  Future<SchoolDepartmentModel> getSchoolInfo() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/school/profileData'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return SchoolDepartmentModel.fromJson(data);
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
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
  Future<ScoreCategoryListModel> getBarChartData() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/user/userScoreCategory'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return ScoreCategoryListModel.fromJson(data);
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
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
  Future<UserRefferalInfoModel> getUserRefferalInfo() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/user/getUserCoin'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return UserRefferalInfoModel.fromJson(data['userStats']);
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
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
  Future<UserCashoutRequestsModel> getUserCashoutRequests() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/userCashOutRequest'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return UserCashoutRequestsModel.fromJson(data);
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        throw AuthenticationException(
            errorMessage: 'Expired or invalid token used');
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
}
