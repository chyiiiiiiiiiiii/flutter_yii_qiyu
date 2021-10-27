import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'model/qiyu_user_info_data.dart';

class Qiyu {
  static const String tag = 'Qiyu';

  static const MethodChannel _channel = MethodChannel('qiyu');

  // 初始化
  // 1. 七魚後台的App Key
  // 2. 添加APP之後顯示的App Name
  // 3. Android推播，給開發者進行伺服器推播使用，DB可能需要紀錄每個用戶的裝置ID，對應的是推播Token，經由Token送出推播
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

  static Future<void> setDeviceIdentifier({
    required String deviceIdentifier,
  }) async {
    Map arguments = {
      'deviceIdentifier': deviceIdentifier,
    };
    await _channel.invokeMethod('setDeviceIdentifier', arguments);
  }

  // 設置用戶資訊
  // 1. 用戶ID
  // 2. 用戶的資料清單，每一項資料為一個物件
  // 注意：需要在用戶登出的情況下，才能正常設置新的用戶資訊
  static Future<bool> setUserInfo({
    required String userId,
    required List<QiyuUserInfoData> userInfoDataList,
  }) async {
    if (userId.isEmpty) {
      debugPrint('[$tag] - userId can not be empty');
      return false;
    }
    if (userInfoDataList.isEmpty) {
      debugPrint('[$tag] - data length can not be empty');
      return false;
    }
    // Use json.encode() to get original json-string
    String jsonString = userInfoDataList
        .map((e) {
          return json.encode(e.toJson());
        })
        .toList()
        .toString();
    final bool isSuccessful = await _channel.invokeMethod('setUserInfo', {
      'userId': userId,
      'userInfoDataList': jsonString,
    });
    return isSuccessful;
  }

  // 開啟客服頁面
  static Future<void> showCustomerService() async {
    await _channel.invokeMethod('showCustomerService');
  }

  // 登出用戶
  static Future<bool> logoutUser() async {
    final bool isFinished = await _channel.invokeMethod('logoutUser');
    return isFinished;
  }
}
