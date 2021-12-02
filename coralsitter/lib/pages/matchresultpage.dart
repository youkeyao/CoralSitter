import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:coralsitter/common.dart';
import 'package:coralsitter/widget/speciescard.dart';

class MatchResultPage extends StatefulWidget {
  const MatchResultPage({ Key? key }) : super(key: key);

  @override
  _MatchResultPageState createState() => _MatchResultPageState();
}

class _MatchResultPageState extends State<MatchResultPage> {
  void adopt(BuildContext context, String s) async {
    Uri uri = Uri.parse('http://' + CommonData.server + '/listcoral');
    http.Response response = await http.post(
      uri,
      body: {
        'species': s,
      },
    );
    Map<dynamic, dynamic> responseData = json.decode(response.body);
    Navigator.of(context).pushNamed(MyRouter.adopt, arguments: responseData['result']);
  }
  @override
  Widget build(BuildContext context) {
    CoralSpecies species = ModalRoute.of(context)?.settings.arguments as CoralSpecies;

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
              top: 17,
              left: ScreenUtil().setWidth(4.5),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white,),
              ),
            ),
            Positioned(
              left: ScreenUtil().setWidth(7.5),
              bottom: 0,
              width: ScreenUtil().setWidth(85),
              child: Column(
                children: [
                  speciesCard(species),
                  SizedBox(height: ScreenUtil().setHeight(2),),
                  SizedBox(
                    width: ScreenUtil().setWidth(85),
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),),
                      onPressed: () => adopt(context, species.species),
                      child: Text("领养这种珊瑚", style: TextStyle(fontSize: 14, color: Color(CommonData.themeColor)),)
                    ),
                  ),
                  Container(
                    height: 32,
                    margin: const EdgeInsets.all(0.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(MyRouter.match);
                      },
                      child: const Text("换一种珊瑚", style: TextStyle(fontSize: 12, color: Colors.white),)
                    )
                  ),
                  SizedBox(height: ScreenUtil().setHeight(3),),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}