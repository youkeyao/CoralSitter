import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget imageButton(String url) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Image.network(
      url,
      fit: BoxFit.fill,
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
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(30.0),
          children: [
            SizedBox(height: ScreenUtil().setHeight(1),),
            const Text("每日精选", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              height: ScreenUtil().screenWidth / 2,
              child: Swiper(
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10.0)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    daily[index],
                    fit: BoxFit.fill,
                  ),
                ),
                itemCount: daily.length,
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
            ),
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
          ],
        ),
      ),
    );
  }
}