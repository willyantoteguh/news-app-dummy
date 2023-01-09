import 'dart:convert';
import 'dart:developer';

import 'package:common/utils/navigation/argument/argument.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:dependencies/webview/webview.dart';
import 'package:favorite/presentation/bloc/favorite_cubit.dart';
import 'package:favorite/presentation/bloc/favorite_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:theme/theme/new_theme.dart';

class WebViewScreen extends StatefulWidget {
  final WebviewArgument argument;

  const WebViewScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  double progress = 0;

  void saveFavorite(ArticleEntity articleEntity) {
    context.read<FavoriteCubit>().addToFavorite(articleEntity);
    log("saveFavorite");
  }

  void deleteFavorite(ArticleEntity articleEntity) {
    context.read<FavoriteCubit>().deleteFavorite(articleEntity);
    log('deleteFavorite');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final status = state.addFavorite.status;
          if (status.isLoading) {
            return Dialog(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else {
            return Container(
              color: ColorName.redColor,
              child: SafeArea(
                  child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(75.h),
                  child: AppBar(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: IconButton(
                        onPressed: () async {
                          controller.clearCache();
                          CookieManager().clearCookies();
                          Navigator.pop(context);
                        },
                        icon: Icon(CupertinoIcons.clear, color: ColorName.whiteColor),
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(widget.argument.title, style: BaseText.whiteTextStyle.copyWith(fontSize: 16.sp)),
                    ),
                    centerTitle: false,
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Row(
                          children: [
                            BlocBuilder<FavoriteCubit, FavoriteState>(builder: (context, state) {
                              final isFavoriteSelected = state.isFavorite;
                              return InkWell(
                                  onTap: () {
                                    ArticleEntity item = ArticleEntity(
                                        author: '',
                                        title: widget.argument.title,
                                        description: '',
                                        url: widget.argument.url,
                                        urlToImage: widget.argument.urlToImage,
                                        publishedAt: widget.argument.publishedAt,
                                        content: '');

                                    if (isFavoriteSelected) {
                                      deleteFavorite(item);

                                      log(isFavoriteSelected.toString());
                                    } else {
                                      saveFavorite(item);

                                      log(isFavoriteSelected.toString());
                                    }
                                  },
                                  child: Icon((isFavoriteSelected) ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark));
                            }),
                            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                          ],
                        ),
                      )
                    ],
                    backgroundColor: ColorName.redColor,
                  ),
                ),
                body: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      color: Colors.red,
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: widget.argument.url,
                        onWebViewCreated: (controller) {
                          setState(() {
                            this.controller = controller;
                          });
                        },
                        onProgress: (progress) {
                          setState(() {
                            this.progress = progress.toDouble() / 100;
                            log(progress.toString());
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )),
            );
          }
        },
      ),
    );
  }
}
