import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coralsitter/common.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    Function callback = ModalRoute.of(context)?.settings.arguments as Function;

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 50,
          title: const Text("设置"),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            TextButton(
              onPressed: () {
                CommonData.me = null;
                CommonData.mycorals.clear();
                Navigator.of(context).pop();
                callback();
              },
              child: const Text("退出登陆", style: TextStyle(fontSize: 20),),)
          ],
        ),
      ),
    );
  }
}