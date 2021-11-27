import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coral/common.dart';
import 'package:coral/settingpage.dart';

Widget meItem(IconData icon, String str, Function() func) {
  return TextButton(
    onPressed: func,
    child: Row(
      children: [
        Icon(icon, color: Colors.black,),
        SizedBox(width: ScreenUtil().setWidth(3),),
        Expanded(child: Text(str, style: const TextStyle(color: Colors.black, fontSize: 12),),),
        const Icon(Icons.keyboard_arrow_right, color: Colors.black,),
      ],
    ),
  );
}

class MePage extends StatefulWidget {
  const MePage({ Key? key, required this.callback }) : super(key: key);
  final Function callback;

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {

  @override
  Widget build(BuildContext context) {
    Widget meBox = CommonData.me == null ? const SizedBox() : Container(
      margin: const EdgeInsets.all(0.0),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8), vertical: ScreenUtil().setHeight(1)),
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20.0)],
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular((10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Card(
                elevation: 10.0,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Image.network(CommonData.me!.avatar, width: ScreenUtil().setWidth(20), height: ScreenUtil().setWidth(20),),
              ),
              SizedBox(width: ScreenUtil().setWidth(8),),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(CommonData.me!.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    Row(
                      children: CommonData.me!.tags.map((e) => Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
                        margin: const EdgeInsets.only(top: 5.0, right: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent[700],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(e, style: const TextStyle(fontSize: 12, color: Colors.white),),
                      )).toList(),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(2),),
          Text(CommonData.me!.sign, style: TextStyle(fontSize: 12, color: Colors.grey[700]),),
        ],
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          titleSpacing: ScreenUtil().setWidth(8),
          elevation: 0.0,
          toolbarHeight: 50,
          title: const Text('个人主页', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("编辑资料", style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
            ),
            SizedBox(width: ScreenUtil().setWidth(5),)
          ],
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black54,
        ),
        body: ListView(
          children: [
            meBox,
            Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8), vertical: ScreenUtil().setHeight(5)),
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(1)),
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(color: Color(0xFFEEEEEE), offset: Offset(0.0, 10.0), blurRadius: 5.0)],
                color: Colors.white,
                borderRadius: BorderRadius.circular((10.0)),
              ),
              child: Column(
                children: [
                  meItem(Icons.payment, "珊瑚卡包", () => null),
                  Container(margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(2.5)), height: 1, child: const Divider(color: Colors.black45,),),
                  meItem(Icons.settings, "设置", () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage(callback: widget.callback))),),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}