import 'package:flutter/cupertino.dart';
import 'package:lmlive/Constant.dart';
import 'package:lmlive/beans/bean/findnews.dart';
import 'package:lmlive/beans/bean/user_info.dart';
import 'package:lmlive/config/storage_manager.dart';

import '../lm_api.dart';

/// App相关接口
class AppRepository {
  //  fun findNews(@Body form: FindNewsForm): Observable<Root<FindNewsResult>>
  static Future<FindNewsBean> checkUpdate(String platform, String version) async {
    debugPrint('检查更新,当前版本为===>$version');
    bool appFirstStart;
    String oldVersion = StorageManager.sharedPreferences.getString(Constant.VERSION);
    if (oldVersion?.isEmpty == true) {
      appFirstStart = true;
      StorageManager.sharedPreferences.setString(Constant.VERSION, version);
    } else {
      if (oldVersion == version) {
        appFirstStart = null;
      } else {
        appFirstStart = true;
        StorageManager.sharedPreferences.setString(Constant.VERSION, version);
      }
    }
    appFirstStart = true;
//    var response = await http.post('user/app/findNews', data: {
//      'appFirstStart': appFirstStart,
//      'homeCategoryVersion': '1',
//      'startAdsVersion': ''
//    });
    //todo test
    var response = await http.post('user/app/findNews',
        data: FindNewsForm(homeCategoryVersion: "1", appFirstStart: true, startAdsVersion: ''));

    var result = FindNewsBean.fromJson(response.data);
    if (result.version.updateType != UpdateType.None) {
      debugPrint('发现新版本===>${result.version.newVersion}');
      return result;
    }
    debugPrint('没有发现新版本');
    return null;
  }
}
