import 'package:flutter/cupertino.dart';

class TimeUtils {
  /// [time]秒数 时间转化 单位 秒 转换成 mm:ss
  static String countDownTimeFormat1(int time) {
    if (time == 0) {
      return "00:00";
    }
    int mi = 60;
//        val hh = mi * 60
//        val dd = hh * 24

//        val day = time / dd
//        val hour = time / hh
    int minute = time ~/ mi;
    int second = (time - minute * mi);

    String strMin = (minute < 10) ? "0$minute" : "$minute";

    String strS = (second < 10) ? "0$second" : "$second";
    debugPrint('countDownTimeFormat1=$strMin:$strS}');
    return "$strMin:$strS";
  }
}
