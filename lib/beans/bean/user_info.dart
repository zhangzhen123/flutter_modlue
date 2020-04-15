class UserInfo {
  String cardAndTicketNew;
  String gainRoyalCard;
  String headPic;
  String isTopLevel;
  String isTopRoyalLevel;
  String nextRoyalName;
  String nickname;
  String royalHeatHtml;
  String royalLevelHtml;
  String royalName;
  String royalStatus;
  String sex;
  String showCardAndTicket;
  String showLocation;
  String showMonthCard;
  String showMonthCardWelfare;
  String showRoyalHeat;
  String showWelfare;
  String usableRoyalCard;
  String userType;
  String welfareTag;
  int beans;
  int royalDiffValue;
  int royalHeat;
  String royalPic;
  int royalLevel;
  int sjNeedExp;
  int userId;
  int userLevel;

  UserInfo(
      {this.cardAndTicketNew,
      this.gainRoyalCard,
      this.headPic,
      this.isTopLevel,
      this.isTopRoyalLevel,
      this.nextRoyalName,
      this.nickname,
      this.royalHeatHtml,
      this.royalLevelHtml,
      this.royalName,
      this.royalStatus,
      this.sex,
      this.showCardAndTicket,
      this.showLocation,
      this.showMonthCard,
      this.showMonthCardWelfare,
      this.showRoyalHeat,
      this.showWelfare,
      this.usableRoyalCard,
      this.userType,
      this.welfareTag,
      this.beans,
      this.royalDiffValue,
      this.royalHeat,
      this.royalPic,
      this.royalLevel,
      this.sjNeedExp,
      this.userId,
      this.userLevel});

  UserInfo.fromJson(Map<String, dynamic> json) {
    this.cardAndTicketNew = json['cardAndTicketNew'];
    this.gainRoyalCard = json['gainRoyalCard'];
    this.headPic = json['headPic'];
    this.isTopLevel = json['isTopLevel'];
    this.isTopRoyalLevel = json['isTopRoyalLevel'];
    this.nextRoyalName = json['nextRoyalName'];
    this.nickname = json['nickname'];
    this.royalHeatHtml = json['royalHeatHtml'];
    this.royalLevelHtml = json['royalLevelHtml'];
    this.royalName = json['royalName'];
    this.royalStatus = json['royalStatus'];
    this.sex = json['sex'];
    this.showCardAndTicket = json['showCardAndTicket'];
    this.showLocation = json['showLocation'];
    this.showMonthCard = json['showMonthCard'];
    this.showMonthCardWelfare = json['showMonthCardWelfare'];
    this.showRoyalHeat = json['showRoyalHeat'];
    this.showWelfare = json['showWelfare'];
    this.usableRoyalCard = json['usableRoyalCard'];
    this.userType = json['userType'];
    this.welfareTag = json['welfareTag'];
    this.beans = json['beans'];
    this.royalDiffValue = json['royalDiffValue'];
    this.royalHeat = json['royalHeat'];
    this.royalPic = json['royalPic'];
    this.royalLevel = json['royalLevel'];
    this.sjNeedExp = json['sjNeedExp'];
    this.userId = json['userId'];
    this.userLevel = json['userLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardAndTicketNew'] = this.cardAndTicketNew;
    data['gainRoyalCard'] = this.gainRoyalCard;
    data['headPic'] = this.headPic;
    data['isTopLevel'] = this.isTopLevel;
    data['isTopRoyalLevel'] = this.isTopRoyalLevel;
    data['nextRoyalName'] = this.nextRoyalName;
    data['nickname'] = this.nickname;
    data['royalHeatHtml'] = this.royalHeatHtml;
    data['royalLevelHtml'] = this.royalLevelHtml;
    data['royalName'] = this.royalName;
    data['royalStatus'] = this.royalStatus;
    data['sex'] = this.sex;
    data['showCardAndTicket'] = this.showCardAndTicket;
    data['showLocation'] = this.showLocation;
    data['showMonthCard'] = this.showMonthCard;
    data['showMonthCardWelfare'] = this.showMonthCardWelfare;
    data['showRoyalHeat'] = this.showRoyalHeat;
    data['showWelfare'] = this.showWelfare;
    data['usableRoyalCard'] = this.usableRoyalCard;
    data['userType'] = this.userType;
    data['welfareTag'] = this.welfareTag;
    data['beans'] = this.beans;
    data['royalDiffValue'] = this.royalDiffValue;
    data['royalHeat'] = this.royalHeat;
    data['royalPic'] = this.royalPic;
    data['royalLevel'] = this.royalLevel;
    data['sjNeedExp'] = this.sjNeedExp;
    data['userId'] = this.userId;
    data['userLevel'] = this.userLevel;
    return data;
  }

  @override
  String toString() {
    return 'UserInfo{cardAndTicketNew: $cardAndTicketNew, gainRoyalCard: $gainRoyalCard, headPic: $headPic, isTopLevel: $isTopLevel, isTopRoyalLevel: $isTopRoyalLevel, nextRoyalName: $nextRoyalName, nickname: $nickname, royalHeatHtml: $royalHeatHtml, royalLevelHtml: $royalLevelHtml, royalName: $royalName, royalStatus: $royalStatus, sex: $sex, showCardAndTicket: $showCardAndTicket, showLocation: $showLocation, showMonthCard: $showMonthCard, showMonthCardWelfare: $showMonthCardWelfare, showRoyalHeat: $showRoyalHeat, showWelfare: $showWelfare, usableRoyalCard: $usableRoyalCard, userType: $userType, welfareTag: $welfareTag, beans: $beans, royalDiffValue: $royalDiffValue, royalHeat: $royalHeat, royalPic: $royalPic, royalLevel: $royalLevel, sjNeedExp: $sjNeedExp, userId: $userId, userLevel: $userLevel}';
  }
}
