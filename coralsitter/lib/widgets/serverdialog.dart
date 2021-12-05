import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:coralsitter/common.dart';

class ServerDialog extends StatefulWidget {
  const ServerDialog({
    Key? key,
    this.progress = const CircularProgressIndicator(),
    this.alpha = 0.6,
    this.textColor = Colors.black,
    required this.child
  }) : super(key: key);
  final Widget child;
  final Widget progress;
  final double alpha;
  final Color textColor;

  @override
  ServerDialogState createState() => ServerDialogState();
}

class ServerDialogState extends State<ServerDialog> {
  bool loading = false;

  Future<Map> post(String route, Map data) async {
    Map<dynamic, dynamic> responseData = {};
    loading = true;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      Uri uri = Uri.parse('http://' + CommonData.server + route);
      http.Response response = await http.post(
        uri,
        body: data,
      );
      responseData = json.decode(response.body);
      loading = false;
    }
    catch(e) {
      print(e);
      Fluttertoast.showToast(msg: '服务器连接失败');
    }
    loading = false;
    setState(() {});
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(widget.child);
    if (loading) {
      Widget layoutProgress;
      layoutProgress = Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0)),
            child: Container(
              padding: const EdgeInsets.only(left:20.0),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.progress,
                Container(
                  margin: const EdgeInsets.only(left:20.0),
                  child: Text(
                    '正在加载...',
                    style: TextStyle(color: widget.textColor, fontSize: 16.0),
                  ),
                ),
                ],
              ),
            ),
        ),
      );
      widgetList.add(Opacity(
        opacity: widget.alpha,
        child: const ModalBarrier(color: Colors.black87, dismissible: false,),
      ));
      widgetList.add(layoutProgress);
    }
    return Stack(
      children: widgetList,
    );
  }
}