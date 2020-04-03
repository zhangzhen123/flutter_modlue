import 'package:flutter/services.dart';
import 'package:lmlive/utils/session_utils.dart';

class CommunityUtil {
  static const String CHANNEL_TO_FLUTTER = "plugins/channel_to_flutter";

  static const String CHANNEL_TO_FLUTTER_EVENT =
      "plugins/channel_to_flutter_event";

//全局通信用的
  static const String CHANNEL_TO_NATIVE_GLOBAL =
      "plugins/channel_to_native_global";

//局部页面通信用的
  static const String CHANNEL_TO_NATIVE_LOCAL =
      "plugins/channel_to_native_local";

  static const BasicMessageChannel<dynamic> messageChannel =
      const BasicMessageChannel(CHANNEL_TO_FLUTTER, StandardMessageCodec());

  static const MethodChannel methodChannelGlobal =
      MethodChannel(CHANNEL_TO_NATIVE_GLOBAL);

  static const MethodChannel methodChannelLocal =
      MethodChannel(CHANNEL_TO_NATIVE_LOCAL);

  static const EventChannel _eventChannel =
      EventChannel(CHANNEL_TO_FLUTTER_EVENT);

  ///通信相关声明在这里

//  static const String METHOD_GLOBAL = "globalFun";

//  static const String METHOD_LOCAL = "localFun";

  //原生发过来的函数名称的key
  static const String NATIVE_METHOD_KEY = "method";

  //关闭页面函数
  static const String METHOD_FINISH = "finish";

  //保存用户信息相关
  static const String METHOD_SAVE_USER_INFO = "saveUserInfo";

  ///初始化消息通信入口函数
  static void initMessageHandler() {
    messageChannel.setMessageHandler(handleReceiveMessage);
    _eventChannel.receiveBroadcastStream().listen((data) {
      print("_eventChannel 收到原生发来的信息=$data");
    });
  }

  ///统一执行收到的原生指令
  static Future<void> handleReceiveMessage(dynamic param) async {
    print("收到原生发来的信息=$param");
    var map = param as Map;
    String method = map[NATIVE_METHOD_KEY];
    //todo
    switch (method) {
      case "testFun":
        {
          print("收到testFUn");
          break;
        }
      case METHOD_SAVE_USER_INFO:
        {
          SessionUtils.instance.setSession(map);
          break;
        }
    }
  }

  ///向原生应用发出执行相关函数操作 [method]函数名 [params]参数
  static Future funToPlatform(String method, [Map params]) async {
    final result = await methodChannelGlobal.invokeMethod(method, params);
    print("得到原生的支持----$result");
    return result;
  }

  ///向原生页面发出执行相关函数操作 [method]函数名 [params]参数
  static Future funToActivity(String method, [Map params]) async {
    final result = await methodChannelLocal.invokeMethod(method, params);
    print("得到原生的支持----$result");
    return result;
  }
}
