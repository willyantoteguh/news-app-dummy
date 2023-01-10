import 'dart:developer';

import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:discovery/presentation/ui/widgets/build_search_field.dart';
import 'package:discovery/presentation/ui/widgets/build_tile_news.dart';
import 'package:favorite/presentation/bloc/favorite_cubit.dart';
import 'package:favorite/presentation/bloc/favorite_state.dart';
import 'package:flutter/cupertino.dart';
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

                    //// Result View
                    BlocBuilder<FavoriteCubit, FavoriteState>(
                        // final status = state.allDataFavorite.status;

                        builder: (context, state) {
                      final status = state.allDataFavorite.status;

                      // listAllFavorite = state.allDataFavorite.data ?? [];
                      listAllResultFavorite = state.allDataFavorite.data ?? [];

                      if (status.isLoading) {
                        return SizedBox(
                          height: 55.h,
                          width: 75.w,
                          child: Dialog(
                            child: Center(
                              child: CircularProgressIndicator.adaptive(backgroundColor: ColorName.redColor),
                            ),
                          ),
                        );
                      } else if (status.isNoData) {
                        return SizedBox(
                          height: ScreenUtil().screenHeight,
                          width: ScreenUtil().screenWidth,
                          child: Center(
                            child: Column(
                              children: [
                                /// IMAGE
                                Text('Empty Favourite'),
                              ],
                            ),
                          ),
                        );
                      } else if (status.isHasData) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BuildSearchField(
                              context,
                              state,
                              queryKey: query,
                              keySearch: key,
                              controller: searchController,
                              onSearch: onSearchNews(state),
                              clearData: onClearSearch(state, context),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: ScreenUtil().screenWidth,
                              margin: EdgeInsets.only(left: 10.w, right: 10.w),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: state.allDataFavorite.data!.length,
                                itemBuilder: (context, index) {
                                  var item = state.allDataFavorite.data![index];
                                  final timeNew = DateTime.parse(item.publishedAt);

                                  return BuildTitleNews(item: item, timeNew: timeNew);
                                },
                              ),
                            ),
                          ],
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

  // Container buildField(FavoriteState state, BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h, top: 5.h),
  //     height: 45,
  //     width: double.infinity,
  //     child: Form(
  //       key: key,
  //       child: TextFormField(
  //         keyboardType: TextInputType.text,
  //         // autovalidateMode: AutovalidateMode.onUserInteraction,
  //         onChanged: (value) {
  //           setState(() {
  //             query = searchController.text;

  //             onSearchNews(state);
  //             log("onSearch: ${state.allDataFavorite.data!.map((e) => e.title).toList().toString()}");
  //           });
  //         },
  //         // getSelectedValue: (item) {
  //         //   log(item);
  //         // },
  //         controller: searchController,
  //         decoration: InputDecoration(
  //             prefixIcon: Icon(
  //               CupertinoIcons.search,
  //               size: 15,
  //               color: ColorName.redColor,
  //             ),
  //             prefixIconColor: ColorName.redColor,
  //             suffixIcon: (searchController.text.toString() != '' || searchController.text.isNotEmpty)
  //                 ? InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         searchController.clear();

  //                         onClearSearch(state, context);
  //                       });
  //                     },
  //                     child: Icon(
  //                       CupertinoIcons.clear_circled,
  //                       size: 15,
  //                       color: ColorName.redColor,
  //                     ))
  //                 : null,
  //             contentPadding: EdgeInsets.all(6.w),
  //             hintText: " News Title Here",
  //             hintStyle: BaseText.greyTextStyle.copyWith(fontSize: 14.sp),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide: BorderSide(
  //                 color: ColorName.redColor,
  //               ),
  //             ),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide: BorderSide(
  //                 color: ColorName.redColor,
  //               ),
  //             ),
  //             focusColor: ColorName.redColor,
  //             focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                   color: ColorName.redColor,
  //                   width: 1,
  //                 ),
  //                 borderRadius: BorderRadius.circular(10))),
  //       ),
  //     ),
  //   );
  // }

  onClearSearch(FavoriteState state, BuildContext context) {
    query = '';
    state.allDataFavorite.data!.clear();
    getAllFavoriteNews(context);
    log(state.allDataFavorite.data!.map((e) => e.title).toList().toString());
    searchController.clear();
    log(query);
  }

  onSearchNews(FavoriteState state) {
    state.allDataFavorite.data = listAllResultFavorite.where((element) => element.title.toLowerCase().contains(query)).toList();
  }

  // void onSearch() {}

  // void clearData() {}
}
