import 'package:common/utils/flavor/app_flavor.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:home_feature/presentation/bisnis_bloc/bloc.dart';
import 'package:home_feature/presentation/headline_bloc/bloc.dart';
import 'package:home_feature/presentation/hiburan_bloc/bloc.dart';
import 'package:home_feature/presentation/home_bloc/home_cubit.dart';
import 'package:home_feature/presentation/kesehatan_bloc/bloc.dart';
import 'package:home_feature/presentation/olahraga_bloc/bloc.dart';
import 'package:home_feature/presentation/ui/bottom_navigation.dart';
import 'package:home_feature/presentation/ui/home_screen.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, __) {
      return MaterialApp(
          debugShowCheckedModeBanner: Config.isDebug,
          title: 'Flutter Github',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
              BlocProvider<HeadlineCubit>(create: (_) => HeadlineCubit(getHeadlineNewsUseCase: sl())),
              BlocProvider<BisnisCubit>(create: (_) => BisnisCubit(getBisnisNewsUseCase: sl())),
              BlocProvider<HiburanCubit>(create: (_) => HiburanCubit(getHiburanNewsUseCase: sl())),
              BlocProvider<KesehatanCubit>(create: (_) => KesehatanCubit(getKesehatanNewsUseCase: sl())),
              BlocProvider<OlahragaCubit>(create: (_) => OlahragaCubit(getOlahragaNewsUseCase: sl())),
            ],
            child: const BottomNavigation(),
          ));
    });
  }
}
