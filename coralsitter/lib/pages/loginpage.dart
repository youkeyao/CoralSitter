import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coralsitter/pages/logintextpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key, required this.callback }) : super(key: key);
  final Function callback;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color? background = Colors.blueAccent[700];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: background,
        body: ListView(
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(10),),
            const Text("Welcome to", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'Times New Roman'),),
            const Text("CoralSitter", textAlign: TextAlign.center, style: TextStyle(fontSize: 60, color: Colors.white, fontFamily: 'Times New Roman'),),
            SizedBox(height: ScreenUtil().setHeight(10),),
            Icon(Icons.flutter_dash, color: Colors.white, size: ScreenUtil().setHeight(35),),
            SizedBox(height: ScreenUtil().setHeight(10),),
            // login button
            Container(
              height: ScreenUtil().setHeight(5),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginTextPage(callback: widget.callback))),
                child: Text("Log in", style: TextStyle(fontSize: 15, color: background),)
              )
            ),
            // Container(
            //   height: ScreenUtil().setHeight(4),
            //   margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            //   child: TextButton(
            //     onPressed: () {},
            //     child: const Text("have no account?", style: TextStyle(fontSize: 12, color: Colors.white30),)
            //   )
            // ),
          ],
        ),
      ),
    );
  }
}