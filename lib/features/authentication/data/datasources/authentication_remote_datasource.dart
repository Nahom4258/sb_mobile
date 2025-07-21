import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/core.dart';

import '../../../../core/constants/app_keys.dart';
import '../../authentication.dart';

import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDatasource {
  Future<UserCredentialModel> signup({
    required String emailOrPhoneNumber,
    required String password,
    required String firstName,
    required String lastName,
    required String otp,
    String? refferalId,
  });
  Future<UserCredentialModel> login({
    required String emailOrPhoneNumber,
    required String password,
  });
  Future<void> forgetPassword({
    required String emailOrPhoneNumber,
    required String otp,
  });
  Future<void> changePassword({
    required String emailOrPhoneNumber,
    required String newPassword,
    required String confirmPassword,
    required String otp,
  });
  Future<void> sendOtpVerification(
      String emailOrPhoneNumber, bool isForForgotPassword);
  Future<void> resendOtpVerification(String emailOrPhoneNumber);
  Future<void> storeDeviceToken();
  Future<void> deleteDeviceToken();
  Future<UserCredentialModel> signInWithGoogle(
      {required String idToken, String? referredBy});
  Future<UserCredentialModel> signInWithApple({String? referredBy});
  Future<void> signOut();
}

class AuthenticationRemoteDatasourceImpl
    extends AuthenticationRemoteDatasource {
  // final http.Client client;
  final InterceptedClient client;

  AuthenticationRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<UserCredentialModel> login(
      {required String emailOrPhoneNumber, required String password}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/user/login'),
        body: json.encode({
          'email_phone': emailOrPhoneNumber,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body)['data'];
        return UserCredentialModel.fromJson(responseJson);
      } else if (response.statusCode == 429) {
        throw RequestOverloadException(errorMessage: 'Too Many Request');
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw AuthenticationException(
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resendOtpVerification(String emailOrPhoneNumber) async {
    final response = await client.post(
      Uri.parse('$baseUrl/user/reSendOTPCode'),
      body: json.encode({
        'email_phone': emailOrPhoneNumber,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 429) {
      throw RequestOverloadException(errorMessage: 'Too Many Request');
    }
    final errorMessage = json.decode(response.body)['message'];
    throw AuthenticationException(errorMessage: errorMessage);
  }

  @override
  Future<void> sendOtpVerification(
      String emailOrPhoneNumber, bool isForForgotPassword) async {
    final url = isForForgotPassword
        ? '$baseUrl/user/sendOTPCodeForgotPass'
        : '$baseUrl/user/sendOTPCode';
    final response = await client.post(
      Uri.parse(url),
      body: json.encode({
        'email_phone': emailOrPhoneNumber,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 429) {
      throw RequestOverloadException(errorMessage: 'Too Many Request');
    }
    final errorMessage = json.decode(response.body)['message'];
    throw AuthenticationException(errorMessage: errorMessage);
  }

  @override
  Future<UserCredentialModel> signup({
    required String emailOrPhoneNumber,
    required String password,
    required String firstName,
    required String lastName,
    required String otp,
    String? refferalId,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/user/signup'),
      body: json.encode({
        'email_phone': emailOrPhoneNumber,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'otp': otp,
        'referredBy': refferalId,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body)['data'];

      return UserCredentialModel.fromJson(responseJson);
    } else if (response.statusCode == 429) {
      throw RequestOverloadException(errorMessage: 'Too Many Request');
    }
    final errorMessage = json.decode(response.body)['message'];
    throw AuthenticationException(errorMessage: errorMessage);
  }

  @override
  Future<void> changePassword({
    required String emailOrPhoneNumber,
    required String newPassword,
    required String confirmPassword,
    required String otp,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/user/forgotChangePassword'),
      body: json.encode({
        'email_phone': emailOrPhoneNumber,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
        'otp': otp,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 429) {
      throw RequestOverloadException(errorMessage: 'Too Many Request');
    }
    final errorMessage = json.decode(response.body)['message'];
    throw AuthenticationException(errorMessage: errorMessage);
  }

  @override
  Future<void> forgetPassword({
    required String emailOrPhoneNumber,
    required String otp,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/user/forgotPassVerifyOTP'),
      body: json.encode({
        'email_phone': emailOrPhoneNumber,
        'otp': otp,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 429) {
      throw RequestOverloadException(errorMessage: 'Too Many Request');
    }
    final errorMessage = json.decode(response.body)['message'];
    throw AuthenticationException(errorMessage: errorMessage);
  }

  @override
  Future<void> deleteDeviceToken() async {
    try {
      final userCredential = await AuthenticationLocalDatasourceImpl(
        flutterSecureStorage: GetIt.instance.get<FlutterSecureStorage>(),
      ).getUserCredential();

      final userId = userCredential.id;

      return await FirebaseFirestore.instance
          .collection(usersDeviceTokenCollection)
          .doc(userId)
          .delete();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> storeDeviceToken() async {
    try {
      final userCredential = await AuthenticationLocalDatasourceImpl(
        flutterSecureStorage: GetIt.instance.get<FlutterSecureStorage>(),
      ).getUserCredential();

      final userId = userCredential.id;

      final deviceToken = await NotificationService().getToken();

      if (deviceToken == null) {
        throw DeviceTokenNotFoundException();
      }

      return await FirebaseFirestore.instance
          .collection(usersDeviceTokenCollection)
          .doc(userId)
          .set(
        {
          "user_id": userId,
          "device_token": deviceToken,
        },
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserCredentialModel> signInWithGoogle(
      {required String idToken, String? referredBy}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/user/googleSingIn'),
        body: json.encode({
          "idToken": idToken,
          'referredBy': referredBy,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        final responseJson = json.decode(response.body)['data'];
        return UserCredentialModel.fromJson(responseJson);
      }
      final errorMessage = json.decode(response.body)['message'];
      throw AuthenticationException(errorMessage: errorMessage);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredentialModel> signInWithApple({String? referredBy}) async {
    try {
      final signupPlatform =
          Platform.isAndroid ? "mobile_android" : "mobile_ios";
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        // webAuthenticationOptions: WebAuthenticationOptions(
        //   redirectUri: Uri.parse(appleSignInCallbackUrl),
        //   clientId: applesSignInClientId,
        // ),
      );

      if (credential.identityToken != null) {
        final firstName = credential.givenName ?? "defaultName";
        final lastName = credential.familyName?? "defaultName";
        final response = await client.post(
          Uri.parse('$baseUrl/user/googleSingIn'),
          body: json.encode({
            "idToken": credential.identityToken.toString(),
            'referredBy': referredBy,
            "appUser": "Ios_user",
            "fName": firstName,
            "lName": lastName
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        final data = json.decode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseJson = json.decode(response.body)['data'];

          return UserCredentialModel.fromJson(responseJson);
        } else {
          throw SignInWithGoogleException(errorMessage: 'User Not Found');
        }
      } else {
        throw SignInWithGoogleException(errorMessage: 'User Not Found');
      }
    } catch (e) {
      throw SignInWithGoogleException(errorMessage: e.toString());

      // return user;
    }
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      // await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw SignInWithGoogleException(errorMessage: e.toString());
    }
  }
}
