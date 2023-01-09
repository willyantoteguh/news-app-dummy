import 'dart:developer';

import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme/new_theme.dart';

class BuildSearchField extends StatefulWidget {
  String queryKey;

  dynamic keySearch;

  TextEditingController controller;

  void Function() clearData;

  void Function() onSearch;

  BuildSearchField(
    this.onSearch, {
    Key? key,
    required this.queryKey,
    required this.keySearch,
    required this.controller,
    required this.clearData,
  }) : super(key: key);

  @override
  State<BuildSearchField> createState() => _BuildSearchFieldState();
}

class _BuildSearchFieldState extends State<BuildSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h, top: 5.h),
      height: 45,
      width: double.infinity,
      child: Form(
        key: widget.keySearch,
        child: TextFormField(
          keyboardType: TextInputType.text,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            setState(() {
              widget.queryKey = widget.controller.text;
              log("onChanged: $widget.query");

              widget.onSearch;
            });
          },
          // getSelectedValue: (item) {
          //   log(item);
          // },
          controller: widget.controller,
          decoration: InputDecoration(
              prefixIcon: Icon(
                CupertinoIcons.search,
                size: 15,
                color: ColorName.redColor,
              ),
              prefixIconColor: ColorName.redColor,
              suffixIcon: (widget.controller.text.toString() != '' || widget.controller.text.isNotEmpty)
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.controller.clear();

                          widget.clearData;
                        });
                      },
                      child: Icon(
                        CupertinoIcons.clear_circled,
                        size: 15,
                        color: ColorName.redColor,
                      ))
                  : null,
              contentPadding: EdgeInsets.all(6.w),
              hintText: " News Title Here",
              hintStyle: BaseText.greyTextStyle.copyWith(fontSize: 14.sp),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: ColorName.redColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: ColorName.redColor,
                ),
              ),
              focusColor: ColorName.redColor,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorName.redColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
