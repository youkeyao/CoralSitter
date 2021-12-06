import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widgets/swipercards.dart';

Widget monitorBox(Color color, IconData icon, String indicator, String value) {
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(width: ScreenUtil().setWidth(22), height: ScreenUtil().setWidth(27),),
      Positioned(
        top: ScreenUtil().setWidth(2),
        child: Container(
          width: ScreenUtil().setWidth(22), 
          height: ScreenUtil().setWidth(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: color,
          ),
        ),
      ),
      Positioned(
        top: 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(4)),
          width: ScreenUtil().setWidth(10), 
          height: ScreenUtil().setWidth(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
            color: color,
          ),
          child: Icon(icon),
        ),
      ),
      Positioned(
        top: ScreenUtil().setWidth(15),
        child: Text(indicator, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
      ),
      Positioned(
        top: ScreenUtil().setWidth(20),
        child: Text(value, style: const TextStyle(fontSize: 12, color: Colors.brown),),
      ),
    ],
  );
}

Widget growBox(String title, String value) {
  return Column(
    children: [
      Text(title, style: const TextStyle(fontSize: 12),),
      const SizedBox(height: 5,),
      Row(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),),
          const SizedBox(width: 5,),
          const Text("cm", style: TextStyle(color: Colors.blue),),
        ],
      ),
    ],
  );
}

class CoralPage extends StatefulWidget {
  const CoralPage({ Key? key }) : super(key: key);

  @override
  _CoralPageState createState() => _CoralPageState();
}

class _CoralPageState extends State<CoralPage> {
  List<String> coralImages = ["http://via.placeholder.com/500x250", "http://via.placeholder.com/500x250", "http://via.placeholder.com/500x250"];
  @override
  Widget build(BuildContext context) {
    CoralInfo coral = ModalRoute.of(context)?.settings.arguments as CoralInfo;

    Widget topArea = Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setWidth(73),
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
        // top bar
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: ScreenUtil().setWidth(100),
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(7), left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(7.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white,),
                ),
                TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)
                        )
                      ),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: Colors.white,
                          width: 1),
                        ),
                    ),
                    onPressed: () {Navigator.of(context).pushNamed('species', arguments: coral.species);},
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(coral.species.species, style: const TextStyle(fontSize: 12, color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Avatar
        Positioned(
          left: ScreenUtil().setWidth(5),
          top: ScreenUtil().setWidth(38),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: ScreenUtil().setWidth(2.5), color: Colors.white),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15.5)),
            ),
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(1)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.pink, Colors.blue,], begin: FractionalOffset(1, 1), end: FractionalOffset(0, 0)),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(13)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: ScreenUtil().setWidth(2), color: Colors.white),
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
                ),
                child: ClipOval(
                  child: Image.network(coral.avatar, width: ScreenUtil().setWidth(20), height: ScreenUtil().setWidth(20),),
                ),
              ),
            ),
          ),
        ),
        // name and tags
        Positioned(
          top: ScreenUtil().setWidth(48),
          left: ScreenUtil().setWidth(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(coral.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(
                width: ScreenUtil().setWidth(40),
                child: Text(
                  coral.species.tags.join(' / '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12,),
                ),
              ),
            ],
          ),
        ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text("种植位置", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                  // const SizedBox(height: 15,),
                  // Image.network(coral.positionImage),
                  // const SizedBox(height: 30,),
                  const Text("每日检测", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                  Text("更新于"+coral.updateTime, style: const TextStyle(fontSize: 10, color: Colors.grey,),),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      monitorBox(const Color(0xFFBBDEFB), Icons.wb_sunny_outlined, "光照强度", coral.light),
                      monitorBox(const Color(0xFFF1F8E9), Icons.waves, "海水气温", coral.temp),
                      monitorBox(const Color(0xFFFFE0B2), Icons.bubble_chart, "微量元素", coral.microelement),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Text("成长指数", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                  Text("更新于"+coral.updateTime, style: const TextStyle(fontSize: 10, color: Colors.grey,),),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      growBox("大小（直径）", coral.size.toString()),
                      const SizedBox(height: 40, child: VerticalDivider(color: Colors.grey, width: 1,)),
                      growBox("距离上次测量", (coral.lastmeasure > 0 ? '+' : '') + coral.lastmeasure.toString()),
                      const SizedBox(height: 40, child: VerticalDivider(color: Colors.grey, width: 1,)),
                      growBox("平均每月增长", coral.growth.toString()),
                    ],
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}