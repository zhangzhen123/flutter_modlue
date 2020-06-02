import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lmlive/beans/bean/findnews.dart';
import 'package:lmlive/config/storage_manager.dart';
import 'package:lmlive/net/services/app_repository.dart';
import 'package:lmlive/provider/view_state_model.dart';
import 'package:lmlive/utils/platform_utils.dart';
import 'package:lmlive/utils/session_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppFirstEntry = 'kAppFirstEntry';

// 主要用于app启动相关
class AppModel with ChangeNotifier {
  bool isFirst = false;
  bool get isSdk => false;

  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(kAppFirstEntry);
    notifyListeners();
  }
}

class AppUpdateModel extends ViewStateModel {
  static const String HOME_CATEGORY = "homeCategory";
  HomePageTab homeCategory;

  Future<FindNewsBean> checkUpdate() async {
    FindNewsBean appUpdateInfo;
    setBusy();
    try {
      var appVersion = await PlatformUtils.getAppVersion();
      appUpdateInfo = await AppRepository.checkUpdate(Platform.operatingSystem, appVersion);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
    debugPrint('appUpdateInfo.homeCategory=${appUpdateInfo.homeCategory.homeCategories}');
    saveTabsInfo(appUpdateInfo.homeCategory);
    return appUpdateInfo;
  }

  ///如果有首页界面分类参数 保存下来
  saveTabsInfo(HomePageTab homeCategory) {
    if (homeCategory == null) return;
    this.homeCategory = homeCategory;
    String json = jsonEncode(homeCategory);
    SessionUtils.instance.setHomeTabs(json);
//    StorageManager.localStorage.setItem(HOME_CATEGORY, homeCategory);
  }

  ///获取tabs 如果缓存没有 取sp
  HomePageTab getTabsInfo() {
    if (homeCategory != null) {
      return homeCategory;
    }

    homeCategory = HomePageTab.fromJson(jsonDecode(SessionUtils.instance.getHomeTabs()));
//    homeCategory = HomePageTab.fromJson(jsonDecode(StorageManager.localStorage.getItem(HOME_CATEGORY)));
    return homeCategory;
  }
}
