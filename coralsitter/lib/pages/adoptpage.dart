import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widget/draggablecards.dart';

Widget infoBox(String title, String content, String unit, CustomAnimationControl control, Function render) {
  return Container(
    width: ScreenUtil().setWidth(18),
    height: ScreenUtil().setWidth(18),
    decoration: BoxDecoration(
      color: Colors.blue[300],
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: ScreenUtil().setWidth(2),),
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.black,),),
        const SizedBox(),
        SizedBox(
          height: ScreenUtil().setWidth(5),
          child: CustomAnimation(
            control: control,
            duration: Duration(milliseconds: (500).round()),
            tween: ColorTween(begin: Color(CommonData.themeColor), end: const Color(0xFF64B5F6)),
            builder: (context, child, Color? value) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: ScreenUtil().setWidth(3),),
                  Text(content, style: TextStyle(fontSize: double.tryParse(content) == null ? 14 : 16, color: value, fontWeight: FontWeight.bold),),
                ] + (unit == '' ? [SizedBox(width: ScreenUtil().setWidth(3),),] : [
                  Text(unit, style: TextStyle(fontSize: 10, color: value, fontWeight: FontWeight.bold),),
                  SizedBox(width: ScreenUtil().setWidth(3),),
                ]),
              );
            },
            onComplete: () => render(),
          )
        ),
        SizedBox(height: ScreenUtil().setWidth(2),),
      ],
    ),
  );
}

class AdoptPage extends StatefulWidget {
  const AdoptPage({ Key? key }) : super(key: key);

  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  CustomAnimationControl control = CustomAnimationControl.stop;
  List corals = [];
  int pos = 0;

  void next() async {
    control = CustomAnimationControl.playFromStart;
    setState(() {});
  }

  void render() async {
    if (control == CustomAnimationControl.playFromStart) {
      control = CustomAnimationControl.playReverseFromEnd;
      pos = (pos + 1) % corals.length;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    corals = ModalRoute.of(context)?.settings.arguments as List;
    
    Widget infoArea = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        infoBox('年龄', (DateTime.now().difference(DateTime.parse(corals[pos].birthtime.replaceAll('.', '-'))).inDays / 365).toStringAsFixed(1), '年', control, render),
        infoBox('培育点', corals[pos].position.substring(0, corals[pos].position.length - 4), '', control, render),
        infoBox('大小', corals[pos].size.toString(), '厘米', control, render),
        infoBox('得分', corals[pos].score.toString(), '', control, render),
      ],
    );

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
              child: DraggableCards(
                width: ScreenUtil().setWidth(100),
                height: ScreenUtil().setHeight(56),
                urls: corals.map((coral) => coral.avatar as String).toList(),
                texts: corals.map((coral) => coral.birthtime as String).toList(),
                getPos: () => (pos+3) % corals.length,
                next: next,
              ),
            ),
            Positioned(
              bottom: 0,
              left: ScreenUtil().setWidth(7.5),
              width: ScreenUtil().setWidth(85),
              child: Column(
                children: [
                  infoArea,
                  SizedBox(height: ScreenUtil().setHeight(3),),
                  const Divider(height: 5, color: Colors.white,),
                  SizedBox(height: ScreenUtil().setHeight(4),),
                  SizedBox(
                    width: ScreenUtil().setWidth(85),
                    height: ScreenUtil().setHeight(5),
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),),
                      onPressed: () {},
                      child: Text("领养这只珊瑚", style: TextStyle(fontSize: 14, color: Color(CommonData.themeColor)),)
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(8),),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}