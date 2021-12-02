import 'package:flutter/material.dart';

class ProfileCardAlignment extends StatelessWidget {
  final int cardNum;
  ProfileCardAlignment(this.cardNum);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: 
          SizedBox(
            width: 200,
            height: 200,
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              child: Image(image: AssetImage('assets/images/box.png'), width: 100, height: 100,),
            ),
          ),
          // SizedBox(
          //   child: Container(
          //     decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //             colors: [Colors.transparent, Colors.black54],
          //             begin: Alignment.center,
          //             end: Alignment.bottomCenter)),
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //       padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text('Card number $cardNum',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 20.0,
          //                   fontWeight: FontWeight.w700)),
          //           Padding(padding: EdgeInsets.only(bottom: 8.0)),
          //           Text('A short description.',
          //               textAlign: TextAlign.start,
          //               style: TextStyle(color: Colors.white)),
          //         ],
          //       )),
          // )
    );
  }
}