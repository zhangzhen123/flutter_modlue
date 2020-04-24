import 'package:flutter/cupertino.dart';
import 'package:lmlive/beans/bean/treasure_box_info.dart';
import 'package:lmlive/beans/bean/tresure_box_award.dart';
import 'package:lmlive/beans/bean/user_more_action.dart';

import '../lm_api.dart';

class LiveRepository {
  /// 导航
  static Future<UserMoreAction> getActionList(int programId) async {
    debugPrint('http.post getActionList ');
    var response = await http.post('live/room/interact/menuInfo', data: {"programId": programId});
    return UserMoreAction.fromJson(response.data);
  }

  /// 在线宝箱查询
  static Future<TreasureBoxInfo> getOnlineTreasure() async {
    var response = await http.post('user/moecoin/task/onlineTreasure');
    return TreasureBoxInfo.fromJson(response.data);
  }

  /// 宝箱领取
  static Future<TreasureBoxAward> saveOnlineTreasure(String treasureCode) async {
    var response = await http.post('user/moecoin/task/saveOnlineTreasure', data: {"treasureCode": treasureCode});
    return TreasureBoxAward.fromJson(response.data);
  }
}
