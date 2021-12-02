import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widget/draggablecards.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({ Key? key }) : super(key: key);

  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  @override
  Widget build(BuildContext context) {
    List corals = ModalRoute.of(context)?.settings.arguments as List;

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
              top: 25,
              child: Text('匹配珊瑚', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Positioned(
              top: ScreenUtil().setHeight(10),
              child: DraggableCards(width: ScreenUtil().setWidth(100), height: ScreenUtil().setHeight(56), urls: ["http://via.placeholder.com/500x500", "http://via.placeholder.com/500x250"], texts: ['2019.09.02', '2021.09.89'],)
            ),
          ],
        )
      ),
    );
  }
}