import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skill_bridge_mobile/core/constants/app_keys.dart';
import 'package:skill_bridge_mobile/core/error/exception.dart';
import 'package:skill_bridge_mobile/features/Notification/data/models/notification_general_model.dart';
import 'package:skill_bridge_mobile/features/Notification/data/models/notification_model.dart';
import 'package:http/http.dart' as http;

abstract class NotificationsRemotedatasource {
  Future<List<NotificationsGeneralModel>> getNotifications();
}

class NotificationsRemotedatasourceImpl
    implements NotificationsRemotedatasource {
  final FlutterSecureStorage flutterSecureStorage;
  // final http.Client client;
  final InterceptedClient client;

  NotificationsRemotedatasourceImpl({
    required this.flutterSecureStorage,
    required this.client,
  });

  @override
  Future<List<NotificationsGeneralModel>> getNotifications() async {
    try {
      final userModel = await flutterSecureStorage.read(key: authenticationKey);

      if (userModel == null) {
        throw UnauthorizedRequestException();
      }

      final userModelJson = json.decode(userModel);
      final token = userModelJson['token'];
      final response = await client.get(
        Uri.parse('$baseUrl/notification'),
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        List<dynamic> fetchedNotifications = data['notifications'];
        List<NotificationsGeneralModel> notifications = fetchedNotifications
            .map((n) => NotificationsGeneralModel.fromJson(n))
            .toList();
        print(notifications);
        return notifications;
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
