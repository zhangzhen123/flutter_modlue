import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lmlive/beans/bean/findnews.dart';
import 'package:lmlive/net/services/app_repository.dart';
import 'package:lmlive/provider/view_state_model.dart';
import 'package:lmlive/utils/platform_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppFirstEntry = 'kAppFirstEntry';

// 主要用于app启动相关
class AppModel with ChangeNotifier {
  bool isFirst = false;

  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(kAppFirstEntry);
    notifyListeners();
  }
}

class AppUpdateModel extends ViewStateModel {
  Future<FindNewsBean> checkUpdate() async {
    FindNewsBean appUpdateInfo;
    setBusy();
    try {
      var appVersion = await PlatformUtils.getAppVersion();
      appUpdateInfo =
          await AppRepository.checkUpdate(Platform.operatingSystem, appVersion);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
    return appUpdateInfo;
  }
}
