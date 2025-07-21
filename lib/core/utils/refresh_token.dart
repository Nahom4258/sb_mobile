import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skill_bridge_mobile/core/constants/app_keys.dart';
import 'package:skill_bridge_mobile/injection_container.dart';
import 'package:http/http.dart' as http;

import '../../features/authentication/data/models/user_credential_model.dart';
import '../core.dart';

final flutterSecureStorage = serviceLocator<FlutterSecureStorage>();
final client = serviceLocator<InterceptedClient>();

Future<void> refreshToken() async {
  final userCredential = await flutterSecureStorage.read(key: authenticationKey);

  if(userCredential == null) {
    throw UnauthorizedRequestException();
  }

  Map<String, dynamic> userCredentialJson = json.decode(userCredential);
  final emailPhone = userCredentialJson['email'];
  final refreshToken = userCredentialJson['refreshToken'];

  final payload = {'email': emailPhone, 'refreshToken': refreshToken};
  
  try{
    final response = await client.post(
        Uri.parse('$baseUrl/user/refreshToken'),
        body: payload,
    );

    if(response.statusCode == 201) {
      var userModel = json.decode(response.body)['data'];
      userCredentialJson['token'] = userModel['token'];
      final userCredentialModelJson = json.encode(userCredentialJson);
      await flutterSecureStorage.write(key: authenticationKey, value: userCredentialModelJson);
    } else {
      throw ServerException();
    }
  } catch(err) {
    rethrow;
  }
}