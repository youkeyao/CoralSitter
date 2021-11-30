import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coralsitter/common.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({ Key? key, required this.species }) : super(key: key);
  final CoralSpecies species;

  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
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
              top: 25,
              child: Text('匹配珊瑚', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Positioned(
              top: 17,
              left: ScreenUtil().setWidth(7.5),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white,),
              ),
            ),
            Positioned(
              left: ScreenUtil().setWidth(7.5),
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.species.species, style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),),
                  Text(widget.species.en, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}