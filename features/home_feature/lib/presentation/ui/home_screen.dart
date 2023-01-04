import 'dart:core';
import 'dart:developer';

import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/carousel_slider/carousel_slider.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/entity/static/news_category.dart';
import 'package:home_feature/presentation/bisnis_bloc/bisnis_cubit.dart';
import 'package:home_feature/presentation/headline_bloc/headline_cubit.dart';
import 'package:home_feature/presentation/headline_bloc/headline_state.dart';
import 'package:theme/theme/new_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsCategory> listCategoryNews = [];
  CarouselController carouselController = CarouselController();
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listCategoryNews = [
      NewsCategory(0, 'Semua', isSelected: true),
      NewsCategory(1, 'Bisnis'),
      NewsCategory(2, 'Hiburan'),
      NewsCategory(3, 'Olahraga'),
      NewsCategory(4, 'Kesehatan'),
    ];
    getHeadlineNews(context, query: '', language: 'id');
    getBisnisNews(context, query: 'bisnis', language: 'id');
  }

  Future getHeadlineNews(BuildContext context, {required String query, required String language}) async {
    HomeRequestEntity params = HomeRequestEntity(q: query, language: language, pageSize: 10, page: 1);

    context.read<HeadlineCubit>().getHeadline(params);
  }

  Future getBisnisNews(BuildContext context, {required String query, required String language}) async {
    HomeRequestEntity params = HomeRequestEntity(q: query, language: language, pageSize: 10, page: 1);

    context.read<BisnisCubit>().getBisnis(params);
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
              child: BlocBuilder<HeadlineCubit, HeadlineState>(builder: (context, state) {
                final status = state.headlineState.status;
                List<ArticleEntity> listImgSlider = state.headlineState.data ?? [];
                List<ArticleEntity> listImages = listImgSlider.sublist(0, 5);

                if (status.isLoading) {
                  return Center(child: CircularProgressIndicator.adaptive(backgroundColor: ColorName.redColor));
                } else if (status.isError) {
                  return Dialog(
                    child: Text(state.headlineState.failure!.errorMessage),
                  );
                } else {
                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listCategoryNews.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = listCategoryNews[index];

                          return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: Text(
                                  data.title,
                                  style: BaseText.blackTextStyle.copyWith(fontWeight: (data.isSelected == true) ? BaseText.semiBold : BaseText.regular, fontSize: 16.sp),
                                ),
                              ));
                        },
                      ),
                    ),
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
                              _current = index;
                            });
                          }),
                      items: listImages.map<Widget>((e) {
                        return Container(
                          child: Stack(
                            children: [
                              Container(
                                // margin: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  // color: ColorName.redColor,
                                  // image: DecorationImage(
                                  //   image: NetworkImage(e.urlToImage),
                                  //   fit: BoxFit.cover,
                                  // ),
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
                                    e.publishedAt,
                                    style: BaseText.whiteTextStyle,
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
                      children: listImages.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => carouselController.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ]);
                }
              }),
            ),
          ),
        )));
  }
}
