import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme/new_theme.dart';

class SelectableTitle extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function onTap;

  SelectableTitle(
    this.text, {
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Text(
            text,
            style: BaseText.blackTextStyle.copyWith(fontWeight: isSelected ? BaseText.semiBold : BaseText.regular, fontSize: 16.sp),
          ),
        ));
  }
}
