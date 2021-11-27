import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widget/swipercards.dart';

class CoralPage extends StatefulWidget {
  const CoralPage({ Key? key, required this.coral }) : super(key: key);
  final CoralInfo coral;

  @override
  _CoralPageState createState() => _CoralPageState();
}

class _CoralPageState extends State<CoralPage> {
  List<String> coralImages = ["http://via.placeholder.com/500x250", "http://via.placeholder.com/500x250", "http://via.placeholder.com/500x250"];
  @override
  Widget build(BuildContext context) {
    Widget topArea = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setWidth(80),
          color: Colors.green,
        ),
        // background image
        Positioned(
          top: 0,
          child: SizedBox(
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setWidth(45),
            child: swiperCards(coralImages, context),
          )
        ),
        // Avatar
        Positioned(
          left: ScreenUtil().setWidth(7.5),
          top: ScreenUtil().setWidth(40),
          child: Container(
            width: ScreenUtil().setWidth(20),
            height: ScreenUtil().setWidth(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(ScreenUtil().setWidth(10)),
              image: DecorationImage(image: NetworkImage(widget.coral.avatar,),),
              // border: Border.all(color: Colors.white, width: ScreenUtil().setWidth(10)),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // name and tags
        // Positioned(
        //   top: ScreenUtil().setWidth(40),
        //   child: Container(
        //     padding: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(13)),
        //     width: ScreenUtil().setWidth(85),
        //     height: ScreenUtil().setWidth(33),
        //     decoration: BoxDecoration(
        //       boxShadow: const [BoxShadow(color: Color(0xFFEEEEEE), offset: Offset(0.0, 10.0), blurRadius: 5.0)],
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular((5.0)),
        //     ),
        //     child: CommonData.me == null ? const SizedBox() : Column(
        //       children: [
        //         Text(CommonData.me!.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: CommonData.me!.tags.map((tag) => Container(
        //             height: 24,
        //             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
        //             margin: const EdgeInsets.only(top: 10.0),
        //             decoration: BoxDecoration(
        //               color: Colors.blueAccent[700],
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //             child: Text(tag, style: const TextStyle(fontSize: 12, color: Colors.white),),
        //           )).toList(),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            topArea,
          ],
        ),
      ),
    );
  }
}