import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widgets/draggablecards.dart';

class CoralIdentityPage extends StatefulWidget {
  const CoralIdentityPage({ Key? key }) : super(key: key);

  @override
  _CoralIdentityPageState createState() => _CoralIdentityPageState();
}

class _CoralIdentityPageState extends State<CoralIdentityPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: Color(CommonData.themeColor),
        body: Stack(
          alignment: Alignment.center,
          children: [
            // background
            Positioned(
              top: 0,
              child: Image.asset('assets/images/coralbackground.png', width: ScreenUtil().setWidth(100),),
            ),
            // top bar
            const Positioned(
              top: 34,
              child: Text('珊瑚', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ],
        )
      ),
    );
  }
}