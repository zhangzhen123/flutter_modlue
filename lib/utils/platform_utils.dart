import 'dart:io';
import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

export 'dart:io';

/// 是否是生产环境
const bool inProduction = const bool.fromEnvironment("dart.vm.product");

class PlatformUtils {
  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getBuildNum() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  static dynamic info;

  static dynamic getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (info != null) {
      return info;
    }
    if (Platform.isAndroid) {
      info = await deviceInfo.androidInfo;
      return info;
    } else if (Platform.isIOS) {
      info = await deviceInfo.iosInfo;
      return info;
    } else {
      return null;
    }
  }
}
