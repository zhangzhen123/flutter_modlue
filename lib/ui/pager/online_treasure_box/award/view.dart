import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lmlive/res/color.dart';
import 'package:lmlive/ui/widget/image.dart';

import 'state.dart';

Widget buildView(TreasureBoxAwardState state, Dispatch dispatch, ViewService viewService) {
  debugPrint("TreasureBoxAwardState=${state.award}");
  var award = state.award;
  return Container(
//    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    width: 270,
    padding: EdgeInsets.only(top: 10, bottom: 20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "恭喜获得",
          style: TextStyle(fontWeight: FontWeight.bold, color: LmColors.black_333, fontSize: 16),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: WrapperImage(url: "${award.awardPic}", height: 50, width: 50, fit: BoxFit.cover),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0.0, 5.0), blurRadius: 5.0)],
              borderRadius: BorderRadius.circular(6)),
          margin: EdgeInsets.only(bottom: 6),
        ),
        Text(
          "${award.awardName}",
          style: TextStyle(fontSize: 10, color: LmColors.black_666),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 15),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 25),
          decoration: BoxDecoration(color: Color(0xFFF9FAFC), borderRadius: BorderRadius.circular(4)),
          child: Text(
            "${award.useInfo}",
            style: TextStyle(fontSize: 10, color: Color(0xff98A4AF)),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(viewService.context).pop();
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: LmColors.theme_color,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
          child: Text(
            "我知道了",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
      ],
    ),
  );
}
