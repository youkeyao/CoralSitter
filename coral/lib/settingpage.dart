import 'package:flutter/material.dart';

import 'package:coral/common.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({ Key? key, required this.callback }) : super(key: key);
  final Function callback;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text("设置"),
        centerTitle: true,
        backgroundColor: Colors.white60,
        foregroundColor: Colors.black54,
      ),
      body: ListView(
        children: [
          TextButton(onPressed: logOff, child: const Text("退出登陆", style: TextStyle(fontSize: 20),),)
        ],
      ),
    );
  }

  void logOff() {
    CommonData.me = null;
    Navigator.of(context).pop();
    widget.callback();
  }
}