import 'package:common/utils/flavor/app_flavor.dart';
import 'package:common/utils/navigation/argument/argument.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:favorite/presentation/bloc/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:home_feature/presentation/category_bloc/bloc.dart';
import 'package:home_feature/presentation/home_bloc/home_cubit.dart';
import 'package:home_feature/presentation/ui/bottom_navigation.dart';
import 'package:home_feature/presentation/ui/home_screen.dart';
import 'package:home_feature/presentation/ui/webview_screen.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, __) {
      return MaterialApp(
        debugShowCheckedModeBanner: Config.isDebug,
        home: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => HomeCubit()),
          BlocProvider(
            create: (_) => FavoriteCubit(
              storeFavoriteNewsUseCase: sl(),
              deleteFavoriteNewsUseCase: sl(),
              getAllFavoriteNewsUseCase: sl(),
            ),
          ),
          BlocProvider(
              create: (_) => CategoryCubit(
                    getHeadlineNewsUseCase: sl(),
                    getBisnisNewsUseCase: sl(),
                    getHiburanNewsUseCase: sl(),
                    getKesehatanNewsUseCase: sl(),
                    getOlahragaNewsUseCase: sl(),
                  )),
        ], child: const BottomNavigation()),
        navigatorKey: NavigationHelperImpl.navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          final argument = settings.arguments;
          switch (settings.name) {
            case AppRoutes.article:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => FavoriteCubit(
                    deleteFavoriteNewsUseCase: sl(),
                    storeFavoriteNewsUseCase: sl(),
                    getAllFavoriteNewsUseCase: sl(),
                  ),
                  child: WebViewScreen(argument: argument as WebviewArgument),
                ),
              );
          }
        },

        // home: MultiBlocProvider(
        //   providers: [
        //     BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        //     BlocProvider<HeadlineCubit>(create: (_) => HeadlineCubit(getHeadlineNewsUseCase: sl())),
        //     BlocProvider<BisnisCubit>(create: (_) => BisnisCubit(getBisnisNewsUseCase: sl())),
        //     BlocProvider<HiburanCubit>(create: (_) => HiburanCubit(getHiburanNewsUseCase: sl())),
        //     BlocProvider<KesehatanCubit>(create: (_) => KesehatanCubit(getKesehatanNewsUseCase: sl())),
        //     BlocProvider<OlahragaCubit>(create: (_) => OlahragaCubit(getOlahragaNewsUseCase: sl())),
        //   ],
        //   child: const BottomNavigation(),
        // )
      );
    });
  }
}
