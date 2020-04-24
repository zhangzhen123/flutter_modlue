class TreasureBoxInfo {
  List<String> awardLogList;
  List<ShowAwardListListBean> showAwardList;
  List<TreasureListListBean> treasureList;
  int receiveNum = 0;

  TreasureBoxInfo({this.showAwardList, this.treasureList, this.awardLogList});

  TreasureBoxInfo.fromJson(Map<String, dynamic> json) {
    this.showAwardList = (json['showAwardList'] as List) != null
        ? (json['showAwardList'] as List).map((i) => ShowAwardListListBean.fromJson(i)).toList()
        : null;
    this.treasureList = (json['treasureList'] as List) != null
        ? (json['treasureList'] as List).map((i) => TreasureListListBean.fromJson(i)).toList()
        : null;
    this.receiveNum = json['receiveNum'];
    List<dynamic> awardLogListList = json['awardLogList'];
    this.awardLogList = new List();
    this.awardLogList.addAll(awardLogListList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showAwardList'] = this.showAwardList != null ? this.showAwardList.map((i) => i.toJson()).toList() : null;
    data['treasureList'] = this.treasureList != null ? this.treasureList.map((i) => i.toJson()).toList() : null;
    data['awardLogList'] = this.awardLogList;
    data['receiveNum'] = this.receiveNum;
    return data;
  }

  @override
  String toString() {
    return 'TreasureBoxInfo{awardLogList: $awardLogList, showAwardList: $showAwardList, treasureList: $treasureList, receiveNum: $receiveNum}';
  }
}

class ShowAwardListListBean {
  String awardName;
  String awardPic;

  ShowAwardListListBean({this.awardName, this.awardPic});

  ShowAwardListListBean.fromJson(Map<String, dynamic> json) {
    this.awardName = json['awardName'];
    this.awardPic = json['awardPic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['awardName'] = this.awardName;
    data['awardPic'] = this.awardPic;
    return data;
  }
}

class TreasureListListBean {
  String awardName;
  String awardPic;
  String status;
  int ttl = 0;
  String treasureCode;

  TreasureListListBean({this.awardName, this.awardPic, this.status, this.treasureCode, this.ttl});

  TreasureListListBean.fromJson(Map<String, dynamic> json) {
    this.awardName = json['awardName'];
    this.awardPic = json['awardPic'];
    this.status = json['status'];
    this.treasureCode = json['treasureCode'];
    this.ttl = json['ttl'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['awardName'] = this.awardName;
    data['awardPic'] = this.awardPic;
    data['status'] = this.status;
    data['treasureCode'] = this.treasureCode;
    data['ttl'] = this.ttl;
    return data;
  }

  @override
  String toString() {
    return 'TreasureListListBean{awardName: $awardName, status: $status, ttl: $ttl}';
  }
}
