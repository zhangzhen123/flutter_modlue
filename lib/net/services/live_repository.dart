import 'package:flutter/cupertino.dart';
import 'package:lmlive/beans/bean/user_more_action.dart';

import '../lm_api.dart';

class LiveRepository {
  // 导航
  static Future<UserMoreAction> getActionList(int programId) async {
    debugPrint('http.post getActionList ');
    var response = await http
        .post('live/room/interact/menuInfo', data: {"programId": programId});
    return UserMoreAction.fromJson(response.data);
  }
}
