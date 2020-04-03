import 'package:flutter/cupertino.dart';

class UserMoreAction {
  ShareInfoBean shareInfo;
  List<MenuItemsListBean> actItems;
  List<MenuItemsListBean> menuItems;

  UserMoreAction({this.shareInfo, this.actItems, this.menuItems});

  UserMoreAction.fromJson(Map<String, dynamic> json) {
    debugPrint("UserMoreAction.fromJson");
    this.shareInfo = json['shareInfo'] != null
        ? ShareInfoBean.fromJson(json['shareInfo'])
        : null;
    this.actItems = (json['actItems'] as List) != null
        ? (json['actItems'] as List)
            .map((i) => MenuItemsListBean.fromJson(i))
            .toList()
        : null;
    this.menuItems = (json['menuItems'] as List) != null
        ? (json['menuItems'] as List)
            .map((i) => MenuItemsListBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shareInfo != null) {
      data['shareInfo'] = this.shareInfo.toJson();
    }
    data['actItems'] = this.actItems != null
        ? this.actItems.map((i) => i.toJson()).toList()
        : null;
    data['menuItems'] = this.menuItems != null
        ? this.menuItems.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class ShareInfoBean {
  String miniUserName;
  String shareBigPic;
  String shareContent;
  String shareId;
  String shareKey;
  String sharePic;
  String shareTitle;
  String shareUrl;
  String touchType;
  String touchValue;
  int userId;

  ShareInfoBean(
      {this.miniUserName,
      this.shareBigPic,
      this.shareContent,
      this.shareId,
      this.shareKey,
      this.sharePic,
      this.shareTitle,
      this.shareUrl,
      this.touchType,
      this.touchValue,
      this.userId});

  ShareInfoBean.fromJson(Map<String, dynamic> json) {
    this.miniUserName = json['miniUserName'];
    this.shareBigPic = json['shareBigPic'];
    this.shareContent = json['shareContent'];
    this.shareId = json['shareId'];
    this.shareKey = json['shareKey'];
    this.sharePic = json['sharePic'];
    this.shareTitle = json['shareTitle'];
    this.shareUrl = json['shareUrl'];
    this.touchType = json['touchType'];
    this.touchValue = json['touchValue'];
    this.userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['miniUserName'] = this.miniUserName;
    data['shareBigPic'] = this.shareBigPic;
    data['shareContent'] = this.shareContent;
    data['shareId'] = this.shareId;
    data['shareKey'] = this.shareKey;
    data['sharePic'] = this.sharePic;
    data['shareTitle'] = this.shareTitle;
    data['shareUrl'] = this.shareUrl;
    data['touchType'] = this.touchType;
    data['touchValue'] = this.touchValue;
    data['userId'] = this.userId;
    return data;
  }
}

//class ActItemsListBean {
//  String itemCode;
//  String itemName;
//  String itemPic;
//  String itemUrl;
//  String miniUserName;
//
//  ActItemsListBean(
//      {this.itemCode,
//      this.itemName,
//      this.itemPic,
//      this.itemUrl,
//      this.miniUserName});
//
//  ActItemsListBean.fromJson(Map<String, dynamic> json) {
//    this.itemCode = json['itemCode'];
//    this.itemName = json['itemName'];
//    this.itemPic = json['itemPic'];
//    this.itemUrl = json['itemUrl'];
//    this.miniUserName = json['miniUserName'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['itemCode'] = this.itemCode;
//    data['itemName'] = this.itemName;
//    data['itemPic'] = this.itemPic;
//    data['itemUrl'] = this.itemUrl;
//    data['miniUserName'] = this.miniUserName;
//    return data;
//  }
//}

class MenuItemsListBean {
  String itemCode;
  String itemName;
  String itemPic;
  String extJsonCfg;
  String itemUrl;
  String tag;
  //小程序id
  String miniUserName;

  Map<String, dynamic> toJson() {
    return {
      "itemCode": this.itemCode,
      "itemName": this.itemName,
      "itemPic": this.itemPic,
      "extJsonCfg": this.extJsonCfg,
      "itemUrl": this.itemUrl,
      "tag": this.tag,
      "miniUserName": this.miniUserName,
    };
  }

  MenuItemsListBean(
      {this.itemCode,
      this.itemName,
      this.itemPic,
      this.extJsonCfg,
      this.itemUrl,
      this.tag,
      this.miniUserName});

  factory MenuItemsListBean.fromJson(Map<String, dynamic> json) {
    return MenuItemsListBean(
      itemCode: json["itemCode"],
      itemName: json["itemName"],
      itemPic: json["itemPic"],
      extJsonCfg: json["extJsonCfg"],
      itemUrl: json["itemUrl"],
      tag: json["tag"],
      miniUserName: json["miniUserName"],
    );
  }
}
