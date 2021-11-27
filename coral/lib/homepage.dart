import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coral/common.dart';

Widget swiperCards(List<String> urls) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    height: ScreenUtil().screenWidth / 2,
    child: Swiper(
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10.0)),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          urls[index],
          fit: BoxFit.fill,
        ),
      ),
      itemCount: urls.length,
      pagination: const SwiperPagination(
        builder: DotSwiperPaginationBuilder(
        color: Colors.black54,
        activeColor: Colors.white,
      )),
      // control: const SwiperControl(),
      scrollDirection: Axis.horizontal,
      autoplay: true,
      onTap: (index) => print('点击了第$index个'),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> daily = ["http://via.placeholder.com/350x150", "http://via.placeholder.com/350x150", "http://via.placeholder.com/350x150"];
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
    Widget myCoralCard = coral == null ? const SizedBox() : Card(
      margin: const EdgeInsets.all(0.0),
      elevation: 10.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      shadowColor: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(coral!.avatar, width: ScreenUtil().setWidth(10), height: ScreenUtil().setWidth(10),),
                  ),
                  const SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(coral!.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(width: 15.0,),
                          Text(coral!.score.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange),),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.room, color: Colors.grey, size: 12,),
                          Text(coral!.position, style: const TextStyle(fontSize: 10, color: Colors.grey),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text("更新于"+coral!.updateTime, style: const TextStyle(fontSize: 10, color: Colors.grey),),
            ],
          ),
        ),
      ),
    );

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
              onPressed: () {},
              child: Column(
                children: [
                  const Text("智能匹配", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                  const Text("领养有缘分的珊瑚", style: TextStyle(fontSize: 10, color: Colors.blue),),
                  const SizedBox(height: 10),
                  Image(image: const AssetImage('assets/images/match.png'), width: ScreenUtil().setWidth(30),),
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
                  const SizedBox(height: 10),
                  Image(image: const AssetImage('assets/images/box.png'), width: ScreenUtil().setWidth(30),),
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
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5), vertical: 10),
          children: [
            const Text("每日精选", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
            swiperCards(daily),
            SizedBox(height: ScreenUtil().setHeight(1),),
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
            myCoralCard,
            const SizedBox(height: 25),
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