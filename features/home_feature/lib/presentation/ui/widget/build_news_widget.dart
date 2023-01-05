import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/carousel_slider/carousel_slider.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:theme/theme/new_theme.dart';
import 'package:dependencies/timeago/timeago_formater.dart' as timeago;

Widget buildNews(
  List<ArticleEntity> listCurrentCategory,
  time,
  BuildContext context,
  List<ArticleEntity> listData,
  carouselController,
  int current,
) {
  return StatefulBuilder(builder: (context, setState) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            }),
        items: listCurrentCategory.map<Widget>((e) {
          //// Formatter
          time = DateTime.parse(e.publishedAt);

          return Container(
            child: Stack(
              children: [
                (e.urlToImage.isNotEmpty || e.urlToImage != '///')
                    ? Container(
                        // margin: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: ColorName.lightBackgroundColor,
                          image: DecorationImage(
                            image: NetworkImage(e.urlToImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: ColorName.lightBackgroundColor,
                        ),
                      ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorName.lightGreyColor.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Text(
                      timeago.format(time, locale: 'ID'),
                      style: BaseText.whiteTextStyle,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.w),
                        bottomRight: Radius.circular(10.w),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ColorName.blackColor.withOpacity(0.5),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: Text(
                      e.title,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: BaseText.whiteTextStyle.copyWith(fontWeight: BaseText.medium, fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listCurrentCategory.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => carouselController.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(shape: BoxShape.circle, color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 10.h),
      Container(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: listData.length,
            itemBuilder: (context, index) {
              var item = listData[index];
              final timeNew = DateTime.parse(item.publishedAt);

              return Container(
                width: ScreenUtil().screenWidth,
                child: Row(
                  children: [
                    (item.urlToImage.isEmpty || item.urlToImage == '///')
                        ? Container(
                            padding: EdgeInsets.only(top: 10.h),
                            height: 100.h,
                            width: 125.w,
                            color: ColorName.lightBackgroundColor,
                            child: Center(child: Text("Image Not Found")),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 10.h),
                            height: 100.h,
                            width: 125.w,
                            child: Image.network(
                              item.urlToImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Container(
                      width: ScreenUtil().screenWidth / 2,
                      child: Padding(
                        padding: EdgeInsets.all(11.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: BaseText.blackTextStyle.copyWith(),
                            ),
                            SizedBox(height: 40.h),
                            Text(
                              timeago.format(time, locale: 'ID'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
      SizedBox(height: 50.h),
    ]);
  });
}
