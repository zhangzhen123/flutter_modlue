import 'package:common_utils/common_utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';

//import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lmlive/utils/platform_utils.dart';
import 'package:lmlive/utils/session_utils.dart';
import 'package:lmlive/utils/string_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_config.dart';
import 'api.dart';
import 'package:dio/src/utils.dart' as dioUtils;
//import '../storage_manager.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    if (kDebugMode) {
      options.baseUrl = ApiConfig.BASE_PRODUCT_URL;
    } else {
      options.baseUrl = ApiConfig.BASE_PRODUCT_URL;
    }

    interceptors
      ..add(ApiInterceptor())
      ..add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: false,
          maxWidth: 2000));
//      ..add(CookieManager(
//          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryData: ${options.data}');
    String header = await getHeaderInfo(options);
    options.contentType;
    options.headers["lmInfo"] = header;
    debugPrint('---api-request--->header--->${options.headers}');
    return options;
  }

  Future<String> getHeaderInfo(RequestOptions options) async {
    var lmInfoParams = StringBuffer();
    if (Platform.isAndroid) {
      lmInfoParams.write("t=A");
    } else {
      lmInfoParams.write("t=I");
    }

    var empty = SessionUtils.instance.getSessionId()?.isNotEmpty;
    if (empty) {
      lmInfoParams.write(
          "&s=${SessionUtils.instance.getSessionId()}"); //SessionId//类型：A：安卓客户端
    }
    var appVersion = await PlatformUtils.getAppVersion();
    var buildNum = await PlatformUtils.getBuildNum();
    lmInfoParams.write("&v=$appVersion.$buildNum"); //版本号 + BuildNumber

    lmInfoParams
        .write("&h=${new DateTime.now().millisecondsSinceEpoch ~/ 1000}");

//    var apptype = BuildConfig.APP_TYPE
//    if (apptype.isNotEmpty()) {
//      append("&a=$apptype")
//    } else if (CommonInit
//        .getInstance()
//        .inSDK) {
//      append("&a=A2")
//    }

//                    JAppChannelCode 内置渠道号
//                    JExtraChannelCode 外部渠道号
//    if (CommonInit
//        .getInstance()
//        .inSDK) {
//      //sdk模式下，直接传XinLiao
//      if (CommonInit.getInstance().getSdkType() ==
//          BusiConstant.SDKType.BAOMIHUA) {
//        append("&c=${BusiConstant.BaoMiHua}")
//      } else {
//        append("&c=${BusiConstant.XinLiao}")
//      }
//    } else {
//      val jAppChannelCode = CommonInit.getInstance()
//          .getCommonListener()
//          ?.getInnerChannel()
//      if (jAppChannelCode?.isNotBlank() == true) {
//        append("&c=$jAppChannelCode")
//      }
//    }

//
//    val jExtraChannelCode = CommonInit.getInstance()
//        .getCommonListener()
//        ?.getExternalChannel()
//    if (jExtraChannelCode?.isNotBlank() == true) {
//      append("&e=$jExtraChannelCode")
//    }
    var dInfo = PlatformUtils.getDeviceInfo();
    if (dInfo is AndroidDeviceInfo) {
      lmInfoParams.write("&o=${dInfo.version}"); //系统版本号
      lmInfoParams.write("&d=${dInfo.device}"); //设备名称
      lmInfoParams.write("&m=${dInfo.model}"); //设备型号
//      lmInfoParams.write("&x=${info.fingerprint}") ;//序列号
    } else if (dInfo is IosDeviceInfo) {
      lmInfoParams.write("&o=${dInfo.systemVersion}"); //系统版本号
      lmInfoParams.write("&d=${dInfo.name}"); //设备名称
      lmInfoParams.write("&m=${dInfo.model}"); //设备型号
//      lmInfoParams.write("&x=${info.identifierForVendor}") ;//序列号
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // 网络类型为移动网络
      lmInfoParams.write("&n=mobile");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // 网络类型为WIFI
      lmInfoParams.write("&n=Wifi");
    }
    //todo
//    if (!DeviceUtils.getUdid().isEmpty()) {
//      append("&i=${SharedPreferencesUtils.getString(ParamConstant.UUID, "")
//          .toUpperCase()}") //设备唯一标识
//    }
    var params = options.data;
//    var strBody = json.encode(params);
    String strBody = StringUtils.parseBodyString(params);
//    if (params is Map) {
//      strBody = dioUtils.encodeMap(params, (key, value) {
//        if (value == null) return null;
//        if (value is String && value.isEmpty) {
//          return null;
//        }
//        return '$key=${Uri.encodeQueryComponent(value.toString())}';
//      });
//    } else {
//      strBody = '';
//    }
    debugPrint('strBody=$strBody');
//    request: Request = chain.request()
//    val body = request.body()
//    var strBody = ""

//    if (body is MultipartBody) {//文件流body不处理
//
//    } else {
//    body?.let {
//    val buffer = Buffer()
//    it.writeTo(buffer)
//
//    var charset: Charset? = Charset.forName("UTF-8")
//    val contentType = it.contentType()
//    if (contentType != null) {
//    charset = contentType!!.charset(charset)
//    }
//    strBody = buffer.readString(charset!!)
//    strBody = StringHelper.parseBodyString(strBody)
//    }
//    }
//
//    val httpUrl: HttpUrl = request.url().newBuilder()
//        .build()
    String apiKey;
    if (Platform.isAndroid) {
      apiKey = ApiConfig.ANDROID_APIKEY;
    } else {
      apiKey = ApiConfig.IOS_APIKEY;
    }
    String value = "$lmInfoParams#$strBody#$apiKey";
    var info = StringUtils.toMD5(value);
//    request = request.newBuilder()
//        .addHeader("lmInfo", "G=$info&$lmInfoParams")
////                .addHeader("JVer", LingMengApp.APP_VERSION)
////                .addHeader("JCTYPE", "ANDROID")
////                .addHeader("JSID", SessionUtils.getSessionId())
////                .addHeader("JPatch", "${SessionUtils.getPatch()}")
//        .apply {
//    //                    val cookies = OpenInstallManager.getChannelParams()
////                    if (cookies.isNotBlank()) {
////                        addHeader("cookie", cookies)
////                    }
//
//
//    }
//        .url(httpUrl).build()
//    }
    return "G=$info&$lmInfoParams";
  }

  @override
  onResponse(Response response) {
//    debugPrint('---api-response--->resp----->${response.toString()}');
    LogUtil.v(
        '---api-response--->${response.request.path}----->${response.toString()}');
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      if (respData.code == ApiConfig.SESSION_PAST) {
        // 如果cookie过期,需要清除本地存储的登录信息
        // StorageManager.localStorage.deleteItem(UserModel.keyUser);
        throw const UnAuthorizedException(); // 需要登录
      } else {
        throw NotSuccessException.fromRespData(respData);
      }
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 200 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
