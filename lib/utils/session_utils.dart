import 'package:flutter/cupertino.dart';
import 'package:lmlive/config/storage_manager.dart';

class SessionUtils {
  static final String SESSION_ID = "SESSION_ID";
  static final String PUSH_PERMIS = "push_permis";
  static final String USER_ID = "USER_ID";
  static final String NICK_NAME = "NICK_NAME";
  static String RONG_IM_TOKEN = "RONG_IM_TOKEN";
  static String IS_REG_USER = "IS_REG_USER";
  static String PIC_ID = "PIC_ID";
  static String NEED_GUARD = "NEED_GUARD";
  static String NEED_GUARD_2 = "NEED_GUARD_2";
  static final String RECHARGED = "RECHARGED";
  static final String AWARD = "AWARD";
  static final String AWARDACTIVE = "AWARDACTIVE";
  static final String SHOWAWARD = "SHOWAWARD";
  static final String RANDOMPROGREMID = "RANDOMPROGREMID";
  static final String NEWCOMERURL = "NEWCOMERURL";
  static final String ISCANGETFREEGIFT = "ISCANGETFREEGIFT";
  static final String USERTYPE = "userType";
  static final String KILL = "KILL";
  static final String WEIXINUSE = "WEIXINUSE";
  static final String QQUSE = "QQUSE";
  static final String ALIPAYUSE = "ALIPAYUSE";
  static final String PATCH = "PATCH";
  static final String PRODUCT = "PRODUCT";
  static final String URL = "URL";
  static final String PRODUCT_KILL = "PRODUCT_KILL";
  static final String GET_RED_PACKET_AWARD = "get_red_packet_award";
  static final String ADVERSION = "ADVERSION";
  static final String TABVERSION = "TABVERSION";
  static final String DEFAULTTAB = "DEFAULTTAB";
  static final String FORCELOGIN = "FORCELOGIN";
  static final String FIRST_GUIDE_ZAN = "FIRST_GUIDE_ZAN";
  static final String FIRST_GUIDE_GESTURE = "FIRST_GUIDE_GRESTURE";
  static final String FIRST_LIVE_GUIDE_GESTURE = "FIRST_LIVE_GUIDE_GRESTURE";
  static final String FIRST_LIVE_SHOW_FOLLOW = "FIRST_LIVE_SHOW_FOLLOW";
  static final String FIRST_RED_POINT = "FIRST_RED_POINT";
  static final String FIRST_STORE_NOTIFICATION = "FIRST_STORE_NOTIFICATION";
  static final String NEED_GUIDE_TO_SPEAK = "NEED_GUIDE_TO_SPEAK";
  static final String GIFT_RULE_NEED_PLAYER_ANIMATION = "NEED_PLAYER_ANIMATION";
  static final String NEED_SHOW_ICON_FANS_BADGE = "NEED_SHOW_ICON_FANS_BADGE";
  static final String NEARBY_REFRESH_DATE = "nearby_refresh_date";
  static final String NEED_SHOW_BANNER_WISH_KOI = "NEED_SHOW_BANNER_WISH_KOI";
  static final String NEED_PASS_SEND_GIFT_TIPS = "need_pass_send_gift_tips";
  static final String RECORD_SHIELD_INFO = "record_shield_info";
  static final String NEED_SHOW_FLIP_CARD_DIALOG = "NEED_SHOW_FLIP_CARD_DIALOG";
  static final String NOTIFY_VERSION = "NOTIFY_VERSION";
  static final String NOTIFY_REFRESH_DATE = "notify_refresh_date";
  static final String RECORD_LIVE_ADCODE = "record_live_adcode";
  static final String RECORD_USER_INFO = "record_user_info";
  static final String RECORD_GOODS_DIALOG = "record_goods_dialog";
  static final String OFFICIAL_OPERATE_DIALOG_ID = "official_operate_dialog_id";
  static SessionUtils _instance;

  static SessionUtils get instance {
    if (_instance == null) {
      _instance = SessionUtils._();
    }
    return _instance;
  }

  SessionUtils._();

  void setSession(Map map) {
    debugPrint("开始保存session  $map");
    if (map != null) {
      this.setSessionId(map[SESSION_ID]);
      this.setUserId(map[USER_ID]);
//      this.setRongImToken(session.getImToken());
      this.setIsRegUser(map[IS_REG_USER]);

      this.setNickName(map[NICK_NAME]);
      this.setUserType(map[USERTYPE]);
//      this.setPicId(session.getHeadPic());
//      this.setPushPermis(session.getHasPushPermis());
    }
  }

  void clearSession() {
    this.setSessionId("");
    this.setUserId(0);
    this.setRongImToken("");
    this.setIsRegUser(false);
    this.setNickName("");
    this.setUserType("");
    this.setPushPermis("");
  }

  String getPushPermis() {
    return StorageManager.sharedPreferences.getString(PUSH_PERMIS) ?? "";
  }

  void setPushPermis(String pushPermis) {
    StorageManager.sharedPreferences.setString(PUSH_PERMIS, pushPermis);
  }

  String getUserType() {
    return StorageManager.sharedPreferences.getString(USERTYPE) ?? "";
  }

  void setUserType(String userType) {
    StorageManager.sharedPreferences.setString(USERTYPE, userType);
  }

  String getSessionId() {
    return StorageManager.sharedPreferences.getString(SESSION_ID) ?? "";
  }

  void setSessionId(String sessionId) {
    StorageManager.sharedPreferences.setString(SESSION_ID, sessionId);
  }

  int getUserId() {
    return StorageManager.sharedPreferences.getInt(USER_ID) ?? 0;
  }

  void setUserId(int userId) {
    StorageManager.sharedPreferences.setInt(USER_ID, userId);
  }

  String getNickName() {
    return StorageManager.sharedPreferences.getString(NICK_NAME) ?? "";
  }

  void setNickName(String nickName) {
    StorageManager.sharedPreferences.setString(NICK_NAME, nickName);
  }

  String getRongImToken() {
    return StorageManager.sharedPreferences.getString(RONG_IM_TOKEN) ?? "";
  }

  void setRongImToken(String rongImToken) {
    StorageManager.sharedPreferences.setString(RONG_IM_TOKEN, rongImToken);
  }

  bool getIsRegUser() {
    return StorageManager.sharedPreferences.getBool(IS_REG_USER) ?? false;
  }

  void setIsRegUser(bool isRegUser) {
    StorageManager.sharedPreferences.setBool(IS_REG_USER, isRegUser);
  }

  void setPicId(String picId) {
    StorageManager.sharedPreferences.setString(PIC_ID, picId);
  }

  String getPicId() {
    return StorageManager.sharedPreferences.getString(PIC_ID) ?? "";
  }

  bool getGuardNeed() {
    return StorageManager.sharedPreferences.getBool(NEED_GUARD) ?? true;
  }

  void setGuardNeed(bool needGuard) {
    StorageManager.sharedPreferences.setBool(NEED_GUARD, needGuard);
  }

  bool getGuardNeed_2() {
    return StorageManager.sharedPreferences.getBool(NEED_GUARD_2) ?? true;
  }

  void setGuardNeed_2(bool needGuard) {
    StorageManager.sharedPreferences.setBool(NEED_GUARD_2, needGuard);
  }

  String getNearbyRefreshDate() {
    return StorageManager.sharedPreferences.getString(NEARBY_REFRESH_DATE) ?? "";
  }

  void setNearbyRefreshDate(String date) {
    StorageManager.sharedPreferences.setString(NEARBY_REFRESH_DATE, date);
  }

  void setRecharged(bool recharged) {
    StorageManager.sharedPreferences.setBool(RECHARGED, recharged);
  }

  bool getRecharged() {
    return StorageManager.sharedPreferences.getBool(RECHARGED) ?? true;
  }

  void setAward(bool award) {
    StorageManager.sharedPreferences.setBool(AWARD, award);
  }

  bool getAward() {
    return StorageManager.sharedPreferences.getBool(AWARD) ?? true;
  }

  void setAwardActive(bool active) {
    StorageManager.sharedPreferences.setBool(AWARDACTIVE, active);
  }

  bool getAwardActive() {
    return StorageManager.sharedPreferences.getBool(AWARDACTIVE) ?? false;
  }

  void setShowAwardDialog(bool show) {
    StorageManager.sharedPreferences.setBool(SHOWAWARD, show);
  }

  bool getShowAwardDialog() {
    return StorageManager.sharedPreferences.getBool(SHOWAWARD) ?? false;
  }

  void setRandomProgremId(int progremid) {
    StorageManager.sharedPreferences.setInt(RANDOMPROGREMID, progremid);
  }

  int getRandomProgremId() {
    return StorageManager.sharedPreferences.getInt(RANDOMPROGREMID) ?? 0;
  }

  void setNewcomerUrl(String newUrl) {
    StorageManager.sharedPreferences.setString(NEWCOMERURL, newUrl);
  }

  String getNewcomerUrl() {
    return StorageManager.sharedPreferences.getString(NEWCOMERURL) ?? "";
  }

  void setIsCanGetFreeGift(bool canGet) {
    StorageManager.sharedPreferences.setBool(ISCANGETFREEGIFT, canGet);
  }

  bool getIsCanetFreeGift() {
    return StorageManager.sharedPreferences.getBool(ISCANGETFREEGIFT) ?? true;
  }

  void setIsKill(bool kill) {
    StorageManager.sharedPreferences.setBool(KILL, kill);
  }

  bool getIsKill() {
    return StorageManager.sharedPreferences.getBool(KILL) ?? false;
  }

  void setProduct(int type) {
    StorageManager.sharedPreferences.setInt(PRODUCT, type);
  }

  int getProduct() {
    return StorageManager.sharedPreferences.getInt(PRODUCT) ?? 2;
  }

  void setUrl(String url) {
    StorageManager.sharedPreferences.setString(URL, url);
  }

  String getUrl() {
    return StorageManager.sharedPreferences.getString(URL) ?? "";
  }

  void setProductKill(bool prodect) {
    StorageManager.sharedPreferences.setBool(PRODUCT_KILL, prodect);
  }

  bool getProductKill() {
    return StorageManager.sharedPreferences.getBool(PRODUCT_KILL) ?? false;
  }

  void setWeiXinUse(bool login) {
    StorageManager.sharedPreferences.setBool(WEIXINUSE, login);
  }

  bool getWeiXinUse() {
    return StorageManager.sharedPreferences.getBool(WEIXINUSE) ?? false;
  }

  void setQQUse(bool login) {
    StorageManager.sharedPreferences.setBool(QQUSE, login);
  }

  bool getQQUse() {
    return StorageManager.sharedPreferences.getBool(QQUSE) ?? false;
  }

  void setAlipayUse(bool login) {
    StorageManager.sharedPreferences.setBool(ALIPAYUSE, login);
  }

  bool getAlipayUse() {
    return StorageManager.sharedPreferences.getBool(ALIPAYUSE) ?? false;
  }

  void setPatch(int patchVersion) {
    StorageManager.sharedPreferences.setInt(PATCH, patchVersion);
  }

  int getPatch() {
    return StorageManager.sharedPreferences.getInt(PATCH) ?? 19;
  }

  void setRedPacketAward(bool hasGet) {
    StorageManager.sharedPreferences.setBool(GET_RED_PACKET_AWARD, hasGet);
  }

// $FF: synthetic method
  static void setRedPacketAward$default(SessionUtils var0, bool var1, int var2, Object var3) {
    if ((var2 & 1) != 0) {
      var1 = true;
    }

    var0.setRedPacketAward(var1);
  }

  bool getRedPacketAward() {
    return StorageManager.sharedPreferences.getBool(GET_RED_PACKET_AWARD) ?? false;
  }

  void setAdVersion(String version) {
    StorageManager.sharedPreferences.setString(ADVERSION, version);
  }

  String getAdVersion() {
    return StorageManager.sharedPreferences.getString(ADVERSION) ?? "";
  }

  void setTabVersion(String version) {
    StorageManager.sharedPreferences.setString(TABVERSION, version);
  }

  String getTabVersion() {
    return StorageManager.sharedPreferences.getString(TABVERSION) ?? "1";
  }

  void setForceLogin(bool forceLogin) {
    StorageManager.sharedPreferences.setBool(FORCELOGIN, forceLogin);
  }

  bool getForceLogin() {
    return StorageManager.sharedPreferences.getBool(FORCELOGIN) ?? false;
  }

  void setDefaultCategory(String tab) {
    StorageManager.sharedPreferences.setString(DEFAULTTAB, tab);
  }

  String getDefaultCategory() {
    return StorageManager.sharedPreferences.getString(DEFAULTTAB) ?? "";
  }

  void setVideoFirstZanGuide(bool status) {
    StorageManager.sharedPreferences.setBool(FIRST_GUIDE_ZAN, status);
  }

  bool getVideoFirstZanGuideStatus() {
    return StorageManager.sharedPreferences.getBool(FIRST_GUIDE_ZAN) ?? true;
  }

  void setVideoFirstGestureGuide(bool status) {
    StorageManager.sharedPreferences.setBool(FIRST_GUIDE_GESTURE, status);
  }

  bool getVideoFirstGestureGuideStatus() {
    return StorageManager.sharedPreferences.getBool(FIRST_GUIDE_GESTURE) ?? true;
  }

  void setLiveFirstGestureGuide(bool status) {
    StorageManager.sharedPreferences.setBool(FIRST_LIVE_GUIDE_GESTURE, status);
  }

  bool getLiveFirstGestureGuideStatus() {
    return StorageManager.sharedPreferences.getBool(FIRST_LIVE_GUIDE_GESTURE) ?? true;
  }

  void setLiveShowFollow(bool status) {
    StorageManager.sharedPreferences.setBool(FIRST_LIVE_SHOW_FOLLOW, status);
  }

  bool getLiveShowFollowStatus() {
    return StorageManager.sharedPreferences.getBool(FIRST_LIVE_SHOW_FOLLOW) ?? true;
  }

  void setVideoFirstRedPoint(int time) {
    StorageManager.sharedPreferences.setInt(FIRST_RED_POINT, time);
  }

  int getVideoFirstRedPointStatus() {
    return StorageManager.sharedPreferences.getInt(FIRST_RED_POINT) ?? 0;
  }

  void setStoreFirstNotify(bool status) {
    StorageManager.sharedPreferences.setBool(FIRST_STORE_NOTIFICATION, status);
  }

  bool getStoreFirstNotify() {
    return StorageManager.sharedPreferences.getBool(FIRST_STORE_NOTIFICATION) ?? false;
  }

  void setNeedGuideToSpeak(bool status) {
    StorageManager.sharedPreferences.setBool(NEED_GUIDE_TO_SPEAK, status);
  }

  bool getNeedGuideToSpeakStatus() {
    return StorageManager.sharedPreferences.getBool(NEED_GUIDE_TO_SPEAK) ?? true;
  }

  void setNeedGiftRulePlayer(bool status) {
    StorageManager.sharedPreferences.setBool(GIFT_RULE_NEED_PLAYER_ANIMATION, status);
  }

  bool getNeedGiftRulePlayer() {
    return StorageManager.sharedPreferences.getBool(GIFT_RULE_NEED_PLAYER_ANIMATION) ?? true;
  }

  void setNeedShowIconFasnBadge(bool status) {
    StorageManager.sharedPreferences.setBool(NEED_SHOW_ICON_FANS_BADGE, status);
  }

  bool getNeedShowIconFasnBadge() {
    return StorageManager.sharedPreferences.getBool(NEED_SHOW_ICON_FANS_BADGE) ?? true;
  }

  void setNeedShowBannerWishKoi(bool status) {
    StorageManager.sharedPreferences.setBool(NEED_SHOW_BANNER_WISH_KOI, status);
  }

  bool getNeedShowBannerWishKoi() {
    return StorageManager.sharedPreferences.getBool(NEED_SHOW_BANNER_WISH_KOI) ?? true;
  }

  void setNeedPassSendGiftTips(bool status) {
    StorageManager.sharedPreferences.setBool(NEED_PASS_SEND_GIFT_TIPS, status);
  }

  bool getNeedPassSendGiftTips() {
    return StorageManager.sharedPreferences.getBool(NEED_PASS_SEND_GIFT_TIPS) ?? true;
  }

  void setNeedShowFlipCardDialog(bool status) {
    StorageManager.sharedPreferences.setBool(NEED_SHOW_FLIP_CARD_DIALOG, status);
  }

  bool getNeedShowFlipCardDialog() {
    return StorageManager.sharedPreferences.getBool(NEED_SHOW_FLIP_CARD_DIALOG) ?? true;
  }

  void setNotifyVersion(int version) {
    StorageManager.sharedPreferences.setInt(NOTIFY_VERSION, version);
  }

  int getNotifyVersion() {
    return StorageManager.sharedPreferences.getInt(NOTIFY_VERSION) ?? -1;
  }

  void setNotifyRefreshDate(String date) {
    StorageManager.sharedPreferences.setString(NOTIFY_REFRESH_DATE, date);
  }

  String getNotifyRefreshDate() {
    return StorageManager.sharedPreferences.getString(NOTIFY_REFRESH_DATE) ?? "";
  }

  void setNeedMengGoodsDialog(bool status) {
    StorageManager.sharedPreferences.setBool("record_goods_dialog", status);
  }

  bool isNeedMengGoodsDialog() {
    return StorageManager.sharedPreferences.getBool("record_goods_dialog") ?? true;
  }

  void setLiveAdConfig(String adCode, String result) {
    StorageManager.sharedPreferences.setString(RECORD_LIVE_ADCODE + adCode, '#' + result + this.getLiveAdConfig(adCode));
  }

  String getLiveAdConfig(String adCode) {
    return StorageManager.sharedPreferences.getString(RECORD_LIVE_ADCODE + adCode) ?? "";
  }

  void setUserInfo(String info) {
    StorageManager.sharedPreferences.setString(RECORD_USER_INFO, info);
  }

//  List getUserInfo
//
//      () {
//    String str = StorageManager.sharedPreferences.getString(RECORD_USER_INFO) ??
//        "";
//    return !TextUtils.isEmpty((CharSequence)str) && StringsKt.contains$default(
//        (CharSequence)str, (CharSequence)"*", false, 2, (Object)null)
//        ? StringsKt.split$default(
//        (CharSequence)str, new String[]{"*"}, false, 0, 6, (Object)null)
//        : null;
//  }

  void setOfficialOperateID(int id) {
    StorageManager.sharedPreferences.setInt(OFFICIAL_OPERATE_DIALOG_ID, id);
  }

  int getOfficialOperateID() {
    return StorageManager.sharedPreferences.getInt(OFFICIAL_OPERATE_DIALOG_ID) ?? 0;
  }

  void setLoginOut() {
    this.setRecharged(false);
    this.setAward(false);
  }
}
