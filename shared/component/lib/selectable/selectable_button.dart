import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme/new_theme.dart';

class SelectableButton extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  SelectableButton(this.text, {this.isSelected = false, this.isEnabled = true, this.width = 144, this.height = 60, required this.onTap, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: (!isEnabled)
                  ? ColorName.lightSelectedColor
                  : isSelected
                      ? ColorName.redColor
                      : Colors.transparent,
              border: Border.all(
                  color: (!isEnabled)
                      ? ColorName.lightSelectedColor
                      : isSelected
                          ? Colors.transparent
                          : ColorName.lightSelectedColor)),
          child: Center(child: Text(text ?? "None", style: (textStyle ?? BaseText.blackTextStyle).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400))),
        ));
  }
}
