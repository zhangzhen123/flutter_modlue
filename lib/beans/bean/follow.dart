class Follow {
  String anchorPic;
  String isLiving;
  String isPcLive;
  String lastShowTime;
  String lastStopTime;
  String programName;
  String pushOpen;
  int anchorLevel;
  int onlineUserNum;
  int programId;
  int surplusDay;

  Follow(
      {this.anchorPic,
      this.isLiving,
      this.isPcLive,
      this.lastShowTime,
      this.lastStopTime,
      this.programName,
      this.pushOpen,
      this.anchorLevel,
      this.onlineUserNum,
      this.programId,
      this.surplusDay});

  Follow.fromJson(Map<String, dynamic> json) {
    this.anchorPic = json['anchorPic'];
    this.isLiving = json['isLiving'];
    this.isPcLive = json['isPcLive'];
    this.lastShowTime = json['lastShowTime'];
    this.lastStopTime = json['lastStopTime'];
    this.programName = json['programName'];
    this.pushOpen = json['pushOpen'];
    this.anchorLevel = json['anchorLevel'];
    this.onlineUserNum = json['onlineUserNum'];
    this.programId = json['programId'];
    this.surplusDay = json['surplusDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anchorPic'] = this.anchorPic;
    data['isLiving'] = this.isLiving;
    data['isPcLive'] = this.isPcLive;
    data['lastShowTime'] = this.lastShowTime;
    data['lastStopTime'] = this.lastStopTime;
    data['programName'] = this.programName;
    data['pushOpen'] = this.pushOpen;
    data['anchorLevel'] = this.anchorLevel;
    data['onlineUserNum'] = this.onlineUserNum;
    data['programId'] = this.programId;
    data['surplusDay'] = this.surplusDay;
    return data;
  }
}
