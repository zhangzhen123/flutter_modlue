import 'package:flutter/cupertino.dart';
import 'package:lmlive/beans/base/RootListData.dart';
import 'package:lmlive/beans/bean/follow.dart';
import 'package:lmlive/beans/bean/program.dart';

import '../lm_api.dart';

class ProgramRepository {
  /// 节目列表
  static Future<ProgramData> getProgramList(int limit, String typeCode, int offset) async {
    debugPrint('http.post getProgramList ');
    //var limit: Int = 20, var typeCode: String?, var offset: Int?
    var response = await http.post('live/program/info/list', data: {"limit": limit, "typeCode": typeCode, "offset": offset});
    return ProgramData.fromJson(response.data);
  }

  /// 关注列表
  static Future<RootListData<Follow>> fetchFollowList(int offset) async {
    debugPrint('http.post requestFollowList ');
    //var limit: Int = 20, var typeCode: String?, var offset: Int?
    var response = await http.post('live/program/info/followList', data: {"offset": offset});
    var rts = RootListData.fromJson((item) => Follow.fromJson(item), response.data);
    return rts;
  }

  /// 看过列表
  static Future<RootListData<Follow>> fetchWatchedRecord(int offset) async {
    debugPrint('http.post requestFollowList ');
    //var limit: Int = 20, var typeCode: String?, var offset: Int?
    var response = await http.post('live/program/info/listWatchedRecord', data: {"offset": offset});
    var rts = RootListData.fromJson((item) => Follow.fromJson(item), response.data);
    return rts;
  }

  /// 改变推送开关
  static Future changeFollowPush(String pushOpen, int programId) async {
    debugPrint('http.post changeFollowPush ');
    //var limit: Int = 20, var typeCode: String?, var offset: Int?
    var response = await http.post('live/program/info/changeFollowPush', data: {"pushOpen": pushOpen, "programId": programId});

    return response;
  }
}
