import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skill_bridge_mobile/core/constants/app_keys.dart';
import 'package:skill_bridge_mobile/core/error/exception.dart';
import 'package:skill_bridge_mobile/features/friends/data/models/freinds_model.dart';
import 'package:skill_bridge_mobile/features/friends/data/models/recived_requests_model.dart';
import 'package:skill_bridge_mobile/features/friends/data/models/search_friends_model.dart';
import 'package:skill_bridge_mobile/features/friends/data/models/search_friends_model_with_pagination.dart';
import 'package:skill_bridge_mobile/features/friends/data/models/sent_requests_model.dart';

abstract class FriendsRemoteDataSource {
  Future<List<FriendsModel>> getFriends();
  Future<SearchFriendsModelWithPagination> searchFriends(
      {required int page, required String searchText});
  Future<List<RecievedRequestsModel>> getRecivedRequests();
  Future<List<SentRequestsModel>> getSentRequests();
  Future<void> sendFriendRequest({required String userId});
  Future<void> recieveFriendRequest({required String userId});
  Future<void> withdrawFriendRequest(
      {required String requestId, required bool isForUnfriend});
  Future<void> acceptOrRejectRequest(
      {required String requestId, required bool acceptRequest});
}

class FriendsRemoteDataSourceImpl implements FriendsRemoteDataSource {
  // final http.Client client;
  final InterceptedClient client;
  final FlutterSecureStorage flutterSecureStorage;

  FriendsRemoteDataSourceImpl(
      {required this.client, required this.flutterSecureStorage});

  @override
  Future<List<FriendsModel>> getFriends() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/friend'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        List<dynamic> friendsList = data['friendsList'];
        return friendsList
            .map((friend) => FriendsModel.fromJson(friend))
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
  Future<SearchFriendsModelWithPagination> searchFriends(
      {required int page, required String searchText}) async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse(
            '$baseUrl/friend/search?page=$page&limit=10&search=$searchText'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return SearchFriendsModelWithPagination.fromJson(data);
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
  Future<List<RecievedRequestsModel>> getRecivedRequests() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/friend/invites'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        List<dynamic> searchList = data['pendingRequests'];
        return searchList
            .map((friend) => RecievedRequestsModel.fromJson(friend))
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
  Future<List<SentRequestsModel>> getSentRequests() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/friend/inviteSent'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        List<dynamic> searchList = data['sentRequests'];
        return searchList
            .map((friend) => SentRequestsModel.fromJson(friend))
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
  Future<void> recieveFriendRequest({required String userId}) async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.put(
        Uri.parse('$baseUrl/friend/accept/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
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
  Future<void> sendFriendRequest({required String userId}) async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final reciever = {
        "receiver": userId,
      };
      final response = await client.post(
        Uri.parse('$baseUrl/friend/sendRequest'),
        body: json.encode(reciever),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
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
  Future<void> withdrawFriendRequest(
      {required String requestId, required bool isForUnfriend}) async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];

      final response = await client.delete(
        Uri.parse(
            '$baseUrl/friend/${isForUnfriend ? 'unfriend' : 'cancel'}/$requestId'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
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
  Future<void> acceptOrRejectRequest(
      {required String requestId, required bool acceptRequest}) async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      late Response response;
      if (acceptRequest) {
        response = await client.put(
          Uri.parse('$baseUrl/friend/accept/$requestId'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        );
      } else {
        response = await client.put(
          Uri.parse('$baseUrl/friend/reject/$requestId'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token',
          },
        );
      }

      if (response.statusCode == 200) {
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
