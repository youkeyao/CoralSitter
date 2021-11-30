import 'package:flutter/material.dart';

import 'package:coralsitter/common.dart';

Widget progressBar(value, width, height) {
  return Container(
    width: width,
    height: height.toDouble(),
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(height/2)),
    ),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Color(CommonData.themeColor)),
        borderRadius: BorderRadius.all(Radius.circular(height/2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(height/2)),
        child: LinearProgressIndicator(
          backgroundColor: Color(CommonData.themeColor),
          value: value,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  );
}