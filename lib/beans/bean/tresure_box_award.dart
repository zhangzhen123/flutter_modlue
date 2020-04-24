class TreasureBoxAward {
  String awardName;
  String awardPic;
  String taskFinished;
  String useInfo;

  TreasureBoxAward({this.awardName, this.awardPic, this.taskFinished, this.useInfo});

  TreasureBoxAward.fromJson(Map<String, dynamic> json) {
    this.awardName = json['awardName'];
    this.awardPic = json['awardPic'];
    this.taskFinished = json['taskFinished'];
    this.useInfo = json['useInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['awardName'] = this.awardName;
    data['awardPic'] = this.awardPic;
    data['taskFinished'] = this.taskFinished;
    data['useInfo'] = this.useInfo;
    return data;
  }

  @override
  String toString() {
    return 'TreasureBoxAward{awardName: $awardName, awardPic: $awardPic, taskFinished: $taskFinished, useInfo: $useInfo}';
  }
}
