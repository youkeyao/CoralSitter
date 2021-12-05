import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reorderables/reorderables.dart';

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widgets/coralcard.dart';

class SitterPage extends StatefulWidget {
  const SitterPage({ Key? key }) : super(key: key);

  @override
  _SitterPageState createState() => _SitterPageState();
}

class _SitterPageState extends State<SitterPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> buildMyCorals(BuildContext context) {
    List<Widget> widgets = [const SizedBox(height: 10, key: ValueKey(0),)];
    for (int i = 0; i < CommonData.mycorals.length; i ++) {
      widgets.add(coralCard(CommonData.mycorals[i], context, key: 2*i+1,),);
      widgets.add(SizedBox(height: 20, key: ValueKey(2*i)));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Widget topArea = Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setWidth(80),
        ),
        // background image
        Positioned(
          top: 0,
          child: Image.network("http://via.placeholder.com/500x250", width: ScreenUtil().setWidth(100), height: ScreenUtil().screenWidth * 0.5,),
        ),
        // name and tags
        Positioned(
          top: ScreenUtil().setWidth(40),
          child: Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15), top: ScreenUtil().setWidth(13)),
            width: ScreenUtil().setWidth(85),
            height: ScreenUtil().setWidth(33),
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Color(0xFFEEEEEE), offset: Offset(0.0, 10.0), blurRadius: 5.0)],
              color: Colors.white,
              borderRadius: BorderRadius.circular((5.0)),
            ),
            child: CommonData.me == null ? const SizedBox() : Column(
              children: [
                Text(CommonData.me!.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: CommonData.me!.tags.map((tag) => Container(
                    height: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      color: Color(CommonData.themeColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(tag, style: const TextStyle(fontSize: 12, color: Colors.white),),
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
        // Avatar
        CommonData.me == null ? const SizedBox() : Positioned(
          top: ScreenUtil().setWidth(30),
          child: Container(
            width: ScreenUtil().setWidth(20),
            height: ScreenUtil().setWidth(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(ScreenUtil().setWidth(2)),
              image: DecorationImage(image: NetworkImage(CommonData.me!.avatar,),),
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            topArea,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7.5)),
              child: const Text("我的珊瑚", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7.5)),
              child: ReorderableColumn(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                onReorder: (oldIndex, newIndex) {
                  oldIndex = (oldIndex-1) ~/ 2;
                  newIndex = (newIndex-1) ~/ 2;
                  CoralInfo tmp = CommonData.mycorals.removeAt(oldIndex);
                  CommonData.mycorals.insert(newIndex, tmp);
                  setState(() {
                  });
                },
                children: buildMyCorals(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}