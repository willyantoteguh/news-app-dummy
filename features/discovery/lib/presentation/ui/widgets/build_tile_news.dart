import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:theme/theme/new_theme.dart';
import 'package:dependencies/timeago/timeago_formater.dart' as timeago;

class BuildTitleNews extends StatelessWidget {
  ArticleEntity item;
  DateTime timeNew;

  BuildTitleNews({Key? key, required this.item, required this.timeNew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
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
            height: 130,
            width: ScreenUtil().screenWidth / 2,
            child: Padding(
              padding: EdgeInsets.all(11.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 85,
                    width: ScreenUtil().screenWidth / 2,
                    child: Text(
                      item.title,
                      overflow: TextOverflow.fade,
                      style: BaseText.blackTextStyle.copyWith(),
                    ),
                  ),
                  // SizedBox(height: 20.h),
                  Spacer(),
                  Text(
                    timeago.format(timeNew, locale: 'ID'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
