import 'package:fish_redux/fish_redux.dart';
import 'package:lmlive/beans/bean/program.dart';

class ProgramBannerState implements Cloneable<ProgramBannerState> {
  List<BannerListListBean> bannerList;

  ProgramBannerState({this.bannerList});

  @override
  ProgramBannerState clone() {
    return ProgramBannerState()..bannerList = bannerList;
  }
}

ProgramBannerState initState(Map<String, dynamic> args) {
  return ProgramBannerState();
}
