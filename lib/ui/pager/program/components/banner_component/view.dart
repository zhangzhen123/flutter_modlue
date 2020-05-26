import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lmlive/res/color.dart';
import 'package:lmlive/ui/widget/image.dart';

import '../../view.dart';
import 'state.dart';

Widget buildView(ProgramBannerState state, Dispatch dispatch, ViewService viewService) {
  var banners = state.bannerList;
  var width = ScreenUtil.screenWidthDp - HOME_SPACE * 2;
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    child: Swiper(
      loop: true,
      autoplay: true,
      autoplayDelay: 5000,
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          builder:
              DotSwiperPaginationBuilder(size: 6, activeSize: 6, activeColor: LmColors.theme_color, color: Color(0x99ffffff))),
      itemCount: banners.length,
      itemBuilder: (ctx, index) {
        return InkWell(
            onTap: () {
              var banner = banners[index];
            },
            child: WrapperImage(
              url: banners[index].resUrl,
              width: width,
              height: width * 0.38356,
              fit: BoxFit.cover,
            ));
      },
    ),
  );
}
