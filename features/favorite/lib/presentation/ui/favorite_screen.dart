import 'dart:developer';

import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:discovery/presentation/ui/widgets/build_search_field.dart';
import 'package:discovery/presentation/ui/widgets/build_tile_news.dart';
import 'package:favorite/presentation/bloc/favorite_cubit.dart';
import 'package:favorite/presentation/bloc/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:theme/theme/new_theme.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  //// Search
  final GlobalKey key = GlobalKey();
  final searchController = TextEditingController();
  String query = '';

  List<ArticleEntity> listAllFavorite = [];
  List<ArticleEntity> listAllResultFavorite = [];

  @override
  void initState() {
    super.initState();

    getAllFavoriteNews(context);
  }

  void getAllFavoriteNews(BuildContext context) async {
    context.read<FavoriteCubit>().allDataFavorite();
    log("hoe");
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
                      'Favourite News',
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
                    SizedBox(height: 10.h),

                    //// Result View
                    BlocConsumer<FavoriteCubit, FavoriteState>(listener: (context, state) {
                      final status = state.allDataFavorite.status;

                      if (status.isLoading) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Center(
                                  child: CircularProgressIndicator.adaptive(backgroundColor: ColorName.redColor),
                                ),
                              );
                            });
                      } else if (status.isNoData) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Center(
                                  child: Text('Empty Screen'),
                                ),
                              );
                            });
                      }
                    }, builder: (context, state) {
                      final status = state.allDataFavorite.status;

                      listAllFavorite = state.allDataFavorite.data ?? [];
                      listAllResultFavorite = state.allDataFavorite.data ?? [];

                      if (status.isHasData) {
                        return Container(
                          width: ScreenUtil().screenWidth,
                          margin: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: listAllFavorite.length,
                            itemBuilder: (context, index) {
                              var item = listAllFavorite[index];
                              final timeNew = DateTime.parse(item.publishedAt);

                              return BuildTitleNews(item: item, timeNew: timeNew);
                            },
                          ),
                        );
                      } else {
                        return Placeholder();
                      }
                    }),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void onSearch() {
    listAllFavorite.clear();
    var item = listAllResultFavorite.firstWhere((element) => element.title.toLowerCase().contains(searchController.text));
    listAllFavorite.add(item);
  }

  void clearData() {
    query = '';
    listAllFavorite.clear();
    searchController.clear();
    log(query);
  }
}
