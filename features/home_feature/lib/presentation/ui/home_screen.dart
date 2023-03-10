import 'dart:core';
import 'dart:developer';

import 'package:component/selectable/selectable_text.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/carousel_slider/carousel_slider.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/entity/static/news_category.dart';
import 'package:theme/theme/new_theme.dart';

import '../category_bloc/bloc.dart';
import 'widget/build_news_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsCategory> listCategoryNews = [
    NewsCategory(0, 'Semua', 'general', isSelected: true),
    NewsCategory(1, 'Bisnis', 'business'),
    NewsCategory(2, 'Hiburan', 'entertainment'),
    NewsCategory(3, 'Olahraga', 'health'),
    NewsCategory(4, 'Kesehatan', 'sports'),
  ];
  String selectedCategory = '';

  //// Slider
  CarouselController carouselController = CarouselController();
  int _current = 0;

  List<ArticleEntity> listData = [];
  late dynamic status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSemuaNews(context);
  }

  Future getSemuaNews(BuildContext context) async {
    HomeRequestEntity params = HomeRequestEntity(q: '', category: 'general', language: 'id', pageSize: 10, page: 1);
    context.read<CategoryCubit>().getSemua(params: params);
  }

  Future getBisnisNews(BuildContext context) async {
    HomeRequestEntity params = HomeRequestEntity(q: '', category: 'business', language: 'id', pageSize: 10, page: 1);
    context.read<CategoryCubit>().getBisnis(params: params);
  }

  Future getHiburanNews(BuildContext context) async {
    HomeRequestEntity params = HomeRequestEntity(q: '', category: 'entertainment', language: 'id', pageSize: 10, page: 1);
    context.read<CategoryCubit>().getHiburan(params: params);
  }

  Future getKesehatanNews(BuildContext context) async {
    HomeRequestEntity params = HomeRequestEntity(q: '', category: 'health', language: 'id', pageSize: 10, page: 1);
    context.read<CategoryCubit>().getKesehatan(params: params);
  }

  Future getOlahragaNews(BuildContext context) async {
    HomeRequestEntity params = HomeRequestEntity(q: '', category: 'sports', language: 'id', pageSize: 10, page: 1);
    context.read<CategoryCubit>().getOlahraga(params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.redColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: ColorName.whiteColor,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'NewsApp',
                    style: BaseText.appTextStyle.copyWith(fontWeight: BaseText.black, fontSize: 26.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 35.h,
                    child: Wrap(
                        children: listCategoryNews.map<Widget>((e) {
                      return SelectableTitle(isSelected: selectedCategory.contains(e.title), e.title, onTap: () {
                        selectCategory(e.title);

                        onSelectToFetchData(context);
                      });
                    }).toList()),
                  ),
                  BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
                    if (selectedCategory == 'Olahraga') {
                      status = state.olahragaState.status;
                      listData = state.olahragaState.data ?? [];
                    } else if (selectedCategory == 'Bisnis') {
                      status = state.bisnisState.status;
                      listData = state.bisnisState.data ?? [];
                    } else if (selectedCategory == 'Hiburan') {
                      status = state.hiburanState.status;
                      listData = state.hiburanState.data ?? [];
                    } else if (selectedCategory == 'Kesehatan') {
                      status = state.kesehatanState.status;
                      listData = state.kesehatanState.data ?? [];
                    } else {
                      status = state.semuaState.status;
                      listData = state.semuaState.data ?? [];
                    }

                    List<ArticleEntity> listCurrentCategory = (listData.length < 5)
                        ? listData
                        : (listData.isNotEmpty)
                            ? listData.sublist(0, 5)
                            : [];
                    var time;

                    log(listData.map((e) => e.author).toList().toString());
                    if (listData.isEmpty) {
                      return SizedBox(
                        height: ScreenUtil().screenHeight,
                        child: Center(child: CircularProgressIndicator.adaptive(backgroundColor: ColorName.redColor)),
                      );
                    }

                    return BuildNewsWidget(
                      listCurrentCategory: listCurrentCategory,
                      time: time,
                      context: context,
                      listData: listData,
                      carouselController: carouselController,
                      current: _current,
                    );

                    // else if (status.isError) {
                    //   return Dialog(
                    //     insetAnimationDuration: Duration(seconds: 5),
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 24.h),
                    //       child: Text('Error'),
                    //     ),
                    //   );
                    // }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSelectToFetchData(BuildContext context) {
    if (selectedCategory == 'Olahraga') {
      getOlahragaNews(context);
    } else if (selectedCategory == 'Bisnis') {
      getBisnisNews(context);
    } else if (selectedCategory == 'Hiburan') {
      getHiburanNews(context);
    } else if (selectedCategory == 'Kesehatan') {
      getKesehatanNews(context);
    } else {
      getSemuaNews(context);
    }
  }

  void selectCategory(String title) {
    if (selectedCategory.contains(title)) {
      setState(() {
        selectedCategory = '';
        log(selectedCategory);
      });
    } else {
      setState(() {
        selectedCategory = title;
        log(selectedCategory);
      });
    }
  }
}
