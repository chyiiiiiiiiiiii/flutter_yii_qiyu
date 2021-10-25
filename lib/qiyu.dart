import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'model/qiyu_user_info_data.dart';

class Qiyu {
  static const String tag = 'Qiyu';

  static const MethodChannel _channel = MethodChannel('qiyu');

  static Future<void> initialize({
    required String appKey,
    required String appName,
    required String deviceIdentifier,
  }) async {
    if (appKey.isEmpty) {
      debugPrint('$tag - initialize - key can not be empty');
      return;
    }
    Map arguments = {
      'appKey': appKey,
      'appName': appName,
      'deviceIdentifier': deviceIdentifier,
    };
    await _channel.invokeMethod('initialize', arguments);
  }

  static Future<void> setApnsToken({required String apnsToken}) async {
    if (Platform.isAndroid) {
      debugPrint('$tag - setApnsToken - Android does not need apnsToken');
      return;
    }
    if (apnsToken.isEmpty) {
      debugPrint('$tag - setApnsToken - apnsToken can not be empty');
      return;
    }
    Map arguments = {
      'apnsToken': apnsToken,
    };
    await _channel.invokeMethod('setApnsToken', arguments);
  }

  static Future<void> setUserInfo({
    required String userId,
    required List<QiyuUserInfoData> userInfoDataList,
  }) async {
    if (userId.isEmpty) {
      debugPrint('[$tag] - userId can not be empty');
      return;
    }
    if (userInfoDataList.isEmpty) {
      debugPrint('[$tag] - data length can not be empty');
      return;
    }
    // Use json.encode() to get original json-string
    String jsonString = userInfoDataList
        .map((e) {
          return json.encode(e.toJson());
        })
        .toList()
        .toString();
    await _channel.invokeMethod('setUserInfo', {
      'userId': userId,
      'userInfoDataList': jsonString,
    });
  }

  static Future<void> showCustomerService() async {
    await _channel.invokeMethod('showCustomerService');
  }

  static Future<void> logoutUser() async {
    await _channel.invokeMethod('logoutUser');
  }
}
