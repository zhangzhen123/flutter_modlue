import 'dart:convert';
import 'dart:core';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:html_unescape/html_unescape.dart';
//import 'package:dio/src/utils.dart' as dioUtils;

class StringUtils {
  static String toMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static String urlDecoder(String data) {
    return data == null ? null : HtmlUnescape().convert(data);
  }

  static String removeHtmlLabel(String data) {
    return data?.replaceAll(RegExp('<[^>]+>'), '');
  }

  ///弃用
//  static String paramsDecoder(dynamic data) {
//    var map;
//    if (data is Map) {
//      map = data;
//    } else {
//      //注意 这里约定的转jsonMap方法
//      map = data.toJson();
//    }
//    String strBody = dioUtils.encodeMap(map, (key, value) {
//      if (value == null) return null;
//      if (value is String && value.isEmpty) {
//        return null;
//      }
//      return '$key=${Uri.encodeQueryComponent(value.toString())}';
//    });
//    return strBody;
//  }

  /// 对请求的body进行处理
  static String parseBodyString(dynamic data) {
    var str = "";
    if (data == null) {
      return str;
    }
    Map map;
    if (data is Map) {
      map = data;
    } else {
      //注意 这里约定的转jsonMap方法
      map = data.toJson();
    }
    if (data == null) return str;
    var listKey = map.keys.toList();
    listKey.sort();

    String temp;
    String value;
    for (var key in listKey) {
      value = map[key].toString();
      if (value == null || value.isEmpty) {
        continue;
      }
      temp = key +
          "=" +
          (Uri.encodeQueryComponent(value, encoding: utf8)
              .replaceAll("+", "%20"));
      if ("" == str) {
        str = temp;
      } else {
        str += "&" + temp;
      }
    }
    return str;
  }
}
