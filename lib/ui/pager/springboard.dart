import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Springboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    print("Springboard 创建了");
//    Future.delayed(Duration(milliseconds: 100), () {
//      print("Springboard 我开始关闭了");
//      Navigator.pop(context);
//    });
    return Container();
  }
}
