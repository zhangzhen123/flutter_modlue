import 'package:flutter/widgets.dart';
import 'package:lmlive/beans/base/RootListData.dart';
import 'package:lmlive/beans/bean/follow.dart';
import 'package:lmlive/beans/bean/user_info.dart';

import '../lm_api.dart';

class UserRepository {
  //用户信息详情
  static Future<UserInfo> queryUserDetailInfo(String sessionId) async {
    debugPrint('http.post queryUserDetailInfo ');
    var response = await http.post('user/acct/info/basic', data: {"sessionId": sessionId});
    return UserInfo.fromJson(response.data);
  }

  /// 守护列表
  static Future<RootListData<Follow>> fetchGuardList(int offset) async {
    debugPrint('http.post requestFollowList ');
    //var limit: Int = 20, var typeCode: String?, var offset: Int?
    var response = await http.post('user/acct/info/guardList', data: {"offset": offset});
    var rts = RootListData.fromJson((item) => Follow.fromJson(item), response.data);
    return rts;
  }

  /// 管理列表
  static Future<RootListData<Follow>> fetchManagerList(int offset) async {
    debugPrint('http.post requestFollowList ');
    //var limit: Int = 20, var typeCode: String?, var offset: Int?
    var response = await http.post('user/acct/info/managerList', data: {"offset": offset});
    var rts = RootListData.fromJson((item) => Follow.fromJson(item), response.data);
    return rts;
  }
}
