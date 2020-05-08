class Test {
  String coverPic;
  String isLiving;
  String isPcLive;
  String programName;
  String upRightInfo;
  int positionIndex;
  int programId;
  PlayInfoBean playInfo;

  Test({this.coverPic, this.isLiving, this.isPcLive, this.programName, this.upRightInfo, this.positionIndex, this.programId, this.playInfo});

  Test.fromJson(Map<String, dynamic> json) {    
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

}

class PlayInfoBean {
  String domain;
  String streamKey;
  String type;

  PlayInfoBean({this.domain, this.streamKey, this.type});

  PlayInfoBean.fromJson(Map<String, dynamic> json) {    
    this.domain = json['domain'];
    this.streamKey = json['streamKey'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['streamKey'] = this.streamKey;
    data['type'] = this.type;
    return data;
  }
}
