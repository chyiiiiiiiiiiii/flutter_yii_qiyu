import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiyu/model/qiyu_user_info_data.dart';
import 'dart:async';

import 'package:qiyu/qiyu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    runQiyu();
  }

  Future<void> runQiyu() async {
    // 取得設備ID
    String deviceIdentifier = '';
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final IosDeviceInfo iosDevice = await deviceInfo.iosInfo;
      deviceIdentifier = iosDevice.identifierForVendor;
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo androidDevice = await deviceInfo.androidInfo;
      deviceIdentifier = androidDevice.androidId;
    }
    // 初始化
    await Qiyu.initialize(
        appKey: 'd433ac25ced4170d98a66b3eda15es12', appName: 'qiyu-plugin-example', deviceIdentifier: deviceIdentifier);
    // 設置用戶或更新用戶之前必須確保已經將用戶登出
    final bool isLogoutSuccess = await Qiyu.logoutUser();
    if (isLogoutSuccess) {
      // 設置用戶資訊
      List<QiyuUserInfoData> list = [];
      list.add(QiyuUserInfoData(key: 'real_name', value: 'Test(555)', label: '名字'));
      list.add(QiyuUserInfoData(key: 'mobile_phone', value: '0939552555', label: '電話'));
      list.add(QiyuUserInfoData(key: 'email', value: '555@gmail.com', label: '信箱'));
      list.add(QiyuUserInfoData(key: 'city', value: 'Taipei', label: '城市', index: 0));
      await Qiyu.setUserInfo(userId: 'yii555', userInfoDataList: list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Qiyu example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              Qiyu.showCustomerService();
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'Show Qiyu',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
