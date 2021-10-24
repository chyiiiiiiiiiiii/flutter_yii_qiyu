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
    await Qiyu.initialize(
        appKey: 'xxxxxxxxxxxxxx', appName: 'xxxxxxxxxxxx', deviceIdentifier: '');
    List<QiyuUserInfoData> list = [];
    list.add(QiyuUserInfoData(key: 'real_name', value: 'Yii(Test)', label: '名字'));
    list.add(QiyuUserInfoData(key: 'mobile_phone', value: '0939552333', label: '電話'));
    list.add(QiyuUserInfoData(key: 'email', value: 'yii@gmail.com', label: '信箱'));
    list.add(QiyuUserInfoData(key: 'city', value: 'Taichung', label: '城市', index: 0));
    await Qiyu.setUserInfo(userId: 'yii1321391238', userInfoDataList: list);
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
