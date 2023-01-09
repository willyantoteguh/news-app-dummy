import 'dart:developer';

import 'package:common/utils/helper/helper.dart';
import 'package:common/utils/navigation/argument/argument.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/base/home/base_home.dart';
import 'package:component/selectable/selectable_button.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:dependencies/textfield_search/use_textfield_search.dart';
import 'package:discovery/presentation/ui/widgets/build_tile_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/static/news_category.dart';
import 'package:home_feature/presentation/category_bloc/bloc.dart';
import 'package:theme/theme/new_theme.dart';

import 'widgets/build_search_field.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> with BaseHome {
  List<NewsCategory> listCategoryNews = [
    NewsCategory(0, 'Semua', 'general'),
    NewsCategory(1, 'Bisnis', 'business'),
    NewsCategory(2, 'Hiburan', 'entertainment'),
    NewsCategory(3, 'Olahraga', 'health'),
    NewsCategory(4, 'Kesehatan', 'sports'),
  ];
  late var listData = [];

  //// Search
  final GlobalKey key = GlobalKey();
  final searchController = TextEditingController();

  //// Flag Search
  bool isAnyResult = false;

  //// Params
  String query = '';
  String category = '';

  Future onSearchNews(BuildContext context) async {
    setState(() {
      isAnyResult = true;
    });
    log(query);
    log(category);
    HomeRequestEntity params = HomeRequestEntity(q: query, category: category, language: 'id', pageSize: 10, page: 1);
    context.read<CategoryCubit>().getSemua(params: params);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.redColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorName.whiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Search News',
                    style: BaseText.appTextStyle.copyWith(fontWeight: BaseText.black, fontSize: 26.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BuildSearchField(
                    onSearch,
                    queryKey: query,
                    keySearch: key,
                    controller: searchController,
                    clearData: clearData,
                  ),

                  //// Result View
                  SizedBox(height: 10.h),
                  (isAnyResult == true)
                      ? BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
                          final status = state.semuaState.status;
                          listData = state.semuaState.data ?? [];

                          return Column(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth,
                                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listData.length,
                                    itemBuilder: (context, index) {
                                      var item = listData[index];
                                      final timeNew = DateTime.parse(item.publishedAt);

                                      if (status.isLoading) {
                                        return Center(
                                          child: CircularProgressIndicator.adaptive(),
                                        );
                                      } else {
                                        return InkWell(
                                          onTap: () {
                                            toWebview(
                                              WebviewArgument(
                                                title: item.title,
                                                url: item.url,
                                                urlToImage: item.urlToImage,
                                                publishedAt: item.publishedAt,
                                              ),
                                            );
                                          },
                                          child: BuildTitleNews(item: item, timeNew: timeNew),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          );
                        })
                      : Container(
                          child: Column(
                            children: [
                              Wrap(
                                children: buildSelectableButton(context),
                              ),
                              SizedBox(height: 30.h),
                              Container(
                                height: 35.h,
                                width: ScreenUtil().screenWidth,
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(primary: ColorName.redColor),
                                  icon: Icon(CupertinoIcons.search),
                                  label: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Text(
                                      'Cari',
                                      style: BaseText.whiteTextStyle.copyWith(fontSize: 16.sp),
                                    ),
                                  ),
                                  onPressed: () {
                                    onSearchNews(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          floatingActionButton: (isAnyResult == true)
              ? InkWell(
                  onTap: (() {
                    setState(() {
                      clearData();
                    });
                  }),
                  child: Container(
                    height: 55.h,
                    width: 55.w,
                    child: CircleAvatar(
                      backgroundColor: ColorName.redColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.trash,
                            size: 15.h,
                            color: ColorName.whiteColor,
                          ),
                          Text('Clear',
                              style: BaseText.whiteTextStyle.copyWith(
                                fontWeight: BaseText.light,
                                fontSize: 12.sp,
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }

  void clearData() {
    query = '';
    category = '';
    listData.clear();
    isAnyResult = false;
    searchController.clear();
  }

  void onSearch() {}

  void selectCategory(String value) {
    if (category.contains(value)) {
      setState(() {
        category = '';
        log(category);
      });
    } else {
      setState(() {
        category = value;
        log(category);
      });
    }
  }

  List<Widget> buildSelectableButton(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 2 * 20 - 24) / 2;

    return listCategoryNews
        .map((e) => SelectableButton(
              e.title,
              width: width,
              isSelected: e.value == category,
              onTap: () {
                selectCategory(e.value);
              },
            ))
        .toList();
  }
}
