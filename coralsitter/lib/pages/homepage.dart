import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widget/coralcard.dart';
import 'package:coralsitter/widget/swipercards.dart';
import 'package:coralsitter/cardswiper.dart';
import 'package:coralsitter/alignment.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> daily = ["http://via.placeholder.com/300x150", "http://via.placeholder.com/300x150", "http://via.placeholder.com/300x150"];
  CoralInfo? coral;

  @override
  void initState() {
    super.initState();
    if (CommonData.mycorals.isNotEmpty) {
      coral = CommonData.mycorals[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget adoptCoralCard = Card(
      margin: const EdgeInsets.all(0.0),
      elevation: 10.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      shadowColor: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(MyRouter.match),
              child: Column(
                children: [
                  const Text("智能匹配", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                  const Text("领养有缘分的珊瑚", style: TextStyle(fontSize: 10, color: Colors.blue),),
                  const SizedBox(height: 20),
                  Image(image: const AssetImage('assets/images/match.png'), width: ScreenUtil().setWidth(20), height: ScreenUtil().setWidth(20),),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 120, child: VerticalDivider(color: Colors.grey, width: 1,)),
            TextButton(
              onPressed: () {},
              child: Column(
                children: [
                  const Text("抽选盲盒", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                  const Text("隐藏限定珊瑚形象", style: TextStyle(fontSize: 10, color: Colors.blue),),
                  const SizedBox(height: 20),
                  Image(image: const AssetImage('assets/images/box.png'), width: ScreenUtil().setWidth(20), height: ScreenUtil().setWidth(20),),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 1,
          backgroundColor: Colors.grey[100],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7.5), vertical: 10),
          children: [
            const Text("每日精选", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
            // swiper
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: ScreenUtil().setWidth(45),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: swiperCards(daily, context),
              ),
            ),
            const SizedBox(height: 20),
            // my coral
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("我的珊瑚", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                TextButton(
                  onPressed: () {},
                  child: const Text("查看更多", style: TextStyle(fontSize: 12, color: Colors.grey),)
                ),
              ],
            ),
            coral == null ? const SizedBox() : coralCard(coral!, context),
            const SizedBox(height: 30),
            // adopt coral
            const Text("领养珊瑚", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
            const SizedBox(height: 15),
            adoptCoralCard,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}