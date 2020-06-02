class ProgramData {
  String defaultCategory;
  String hasMore;
  List<BannerListListBean> bannerList;
  List<ProgramListListBean> programList;

  ProgramData({this.defaultCategory, this.hasMore, this.bannerList, this.programList});

  ProgramData.fromJson(Map<String, dynamic> json) {
    this.defaultCategory = json['defaultCategory'];
    this.hasMore = json['hasMore'];
    this.bannerList = (json['bannerList'] as List) != null
        ? (json['bannerList'] as List).map((i) => BannerListListBean.fromJson(i)).toList()
        : null;
    this.programList = (json['programList'] as List) != null
        ? (json['programList'] as List).map((i) => ProgramListListBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defaultCategory'] = this.defaultCategory;
    data['hasMore'] = this.hasMore;
    data['bannerList'] = this.bannerList != null ? this.bannerList.map((i) => i.toJson()).toList() : null;
    data['programList'] = this.programList != null ? this.programList.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class BannerListListBean {
  String adCode;
  String adTitle;
  String canShare;
  String resType;
  String resUrl;
  String touchType;
  String touchValue;

  BannerListListBean({this.adCode, this.adTitle, this.canShare, this.resType, this.resUrl, this.touchType, this.touchValue});

  BannerListListBean.fromJson(Map<String, dynamic> json) {
    this.adCode = json['adCode'];
    this.adTitle = json['adTitle'];
    this.canShare = json['canShare'];
    this.resType = json['resType'];
    this.resUrl = json['resUrl'];
    this.touchType = json['touchType'];
    this.touchValue = json['touchValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adCode'] = this.adCode;
    data['adTitle'] = this.adTitle;
    data['canShare'] = this.canShare;
    data['resType'] = this.resType;
    data['resUrl'] = this.resUrl;
    data['touchType'] = this.touchType;
    data['touchValue'] = this.touchValue;
    return data;
  }
}

class ProgramListListBean {
  String coverPic;
  String isLiving;
  String isPcLive;
  String programName;
  String upRightInfo;
  int positionIndex;
  int programId;
  PlayInfoBean playInfo;

  ProgramListListBean(
      {this.coverPic,
      this.isLiving,
      this.isPcLive,
      this.programName,
      this.upRightInfo,
      this.positionIndex,
      this.programId,
      this.playInfo});

  ProgramListListBean.fromJson(Map<String, dynamic> json) {
    this.coverPic = json['coverPic'];
    this.isLiving = json['isLiving'];
    this.isPcLive = json['isPcLive'];
    this.programName = json['programName'];
    this.upRightInfo = json['upRightInfo'];
    this.positionIndex = json['positionIndex'];
    this.programId = json['programId'];
    this.playInfo = json['playInfo'] != null ? PlayInfoBean.fromJson(json['playInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coverPic'] = this.coverPic;
    data['isLiving'] = this.isLiving;
    data['isPcLive'] = this.isPcLive;
    data['programName'] = this.programName;
    data['upRightInfo'] = this.upRightInfo;
    data['positionIndex'] = this.positionIndex;
    data['programId'] = this.programId;
    if (this.playInfo != null) {
      data['playInfo'] = this.playInfo.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ProgramListListBean{coverPic: $coverPic, isLiving: $isLiving, isPcLive: $isPcLive, programName: $programName, upRightInfo: $upRightInfo, positionIndex: $positionIndex, programId: $programId, playInfo: $playInfo}';
  }
}

class PlayInfoBean {
  //url格式
  static const String Url = "Url";

  //正则表达式格式
  static const String Regex = "Regex";
  String domain;
  String streamKey;
  String type;
  String rtmp;

  PlayInfoBean({this.domain, this.streamKey, this.type, this.rtmp});

  PlayInfoBean.fromJson(Map<String, dynamic> json) {
    this.domain = json['domain'];
    this.streamKey = json['streamKey'];
    this.type = json['type'];
    this.rtmp = json['rtmp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['streamKey'] = this.streamKey;
    data['type'] = this.type;
    data['rtmp'] = this.rtmp;
    return data;
  }

  @override
  String toString() {
    return 'PlayInfoBean{domain: $domain, streamKey: $streamKey, type: $type, rtmp: $rtmp}';
  }
}
