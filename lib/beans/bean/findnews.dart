class FindNewsForm {
  String homeCategoryVersion;
  String startAdsVersion;

  //是否初次启动
  bool appFirstStart;

  FindNewsForm({this.homeCategoryVersion, this.startAdsVersion, this.appFirstStart});

  Map<String, dynamic> toJson() {
    return {
      "homeCategoryVersion": this.homeCategoryVersion,
      "startAdsVersion": this.startAdsVersion,
      "appFirstStart": this.appFirstStart,
    };
  }
}

class FindNewsBean {
  String defaultCategory;
  String forceLogin;
  String refreshStartAds;
  String sessionIsExpired;
  VersionBean version;
  HomePageTab homeCategory;

  FindNewsBean({this.defaultCategory, this.forceLogin, this.refreshStartAds, this.sessionIsExpired, this.version});

  FindNewsBean.fromJson(Map<String, dynamic> json) {
    this.defaultCategory = json['defaultCategory'];
    this.forceLogin = json['forceLogin'];
    this.refreshStartAds = json['refreshStartAds'];
    this.sessionIsExpired = json['sessionIsExpired'];
    this.version = json['version'] != null ? VersionBean.fromJson(json['version']) : null;
    this.homeCategory = json['homeCategory'] != null ? HomePageTab.fromJson(json['homeCategory']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defaultCategory'] = this.defaultCategory;
    data['forceLogin'] = this.forceLogin;
    data['refreshStartAds'] = this.refreshStartAds;
    data['sessionIsExpired'] = this.sessionIsExpired;
    if (this.version != null) {
      data['version'] = this.version.toJson();
    }
    return data;
  }
}

class HomePageTab {
  List<ProgramTab> homeCategories = [];
  String latestHomeCategoryVersion = "";

  HomePageTab({this.homeCategories, this.latestHomeCategoryVersion});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latestHomeCategoryVersion'] = this.latestHomeCategoryVersion;
    if (this.homeCategories != null) {
      data['homeCategories'] = this.homeCategories.map((i) => i.toJson()).toList();
    }
    return data;
  }

  factory HomePageTab.fromJson(Map<String, dynamic> json) {
    return HomePageTab(
      homeCategories: List.of(json["homeCategories"]).map((i) => ProgramTab.fromJson(i)).toList(),
      latestHomeCategoryVersion: json["latestHomeCategoryVersion"],
    );
  }
}

class ProgramTab {
  String typeName = "";
  String typeCode = "";
  int position = 0;

  Map<String, dynamic> toJson() {
    return {
      "typeName": this.typeName,
      "typeCode": this.typeCode,
    };
  }

  ProgramTab({this.typeName, this.typeCode, this.position});

  factory ProgramTab.fromJson(Map<String, dynamic> json) {
    return ProgramTab(
      typeName: json["typeName"],
      typeCode: json["typeCode"],
    );
  }

  @override
  String toString() {
    return 'ProgramTab{typeName: $typeName, typeCode: $typeCode}';
  }
}

class VersionBean {
  String installUrl;
  String md5Code;
  String newVersion;
  String updateContent;
  String updateType;
  String versionType;

  VersionBean({this.installUrl, this.md5Code, this.newVersion, this.updateContent, this.updateType, this.versionType});

  VersionBean.fromJson(Map<String, dynamic> json) {
    this.installUrl = json['installUrl'];
    this.md5Code = json['md5Code'];
    this.newVersion = json['newVersion'];
    this.updateContent = json['updateContent'];
    this.updateType = json['updateType'];
    this.versionType = json['versionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installUrl'] = this.installUrl;
    data['md5Code'] = this.md5Code;
    data['newVersion'] = this.newVersion;
    data['updateContent'] = this.updateContent;
    data['updateType'] = this.updateType;
    data['versionType'] = this.versionType;
    return data;
  }
}
