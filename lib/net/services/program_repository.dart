import 'package:flutter/cupertino.dart';
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
}
