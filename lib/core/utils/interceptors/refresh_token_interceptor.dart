import 'dart:math' as math;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:skill_bridge_mobile/core/utils/refresh_token.dart';
import 'package:skill_bridge_mobile/injection_container.dart';

import '../../constants/app_keys.dart';


final flutterSecureStorage = serviceLocator<FlutterSecureStorage>();

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if(response.statusCode == 401) {
      await refreshToken();
      return true;
    }
    return false;
  }

  @override
  Duration delayRetryAttemptOnResponse({required int retryAttempt}) {
    return const Duration(milliseconds: 250) * math.pow(2.0, retryAttempt);
  }
}