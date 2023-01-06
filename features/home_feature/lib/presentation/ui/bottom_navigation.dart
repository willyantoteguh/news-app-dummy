import 'package:dependencies/bloc/bloc.dart';
import 'package:discovery/presentation/ui/discovery_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme/theme/new_theme.dart';

import '../home_bloc/bloc.dart';
import 'home_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: IndexedStack(
            index: context.read<HomeCubit>().state.homeState.data,
            children: [
              HomeScreen(),
              DiscoveryScreen(),
              Center(
                child: Text('Favorite'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ]),
          child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: context.read<HomeCubit>().state.homeState.data ?? 0,
              onTap: (value) {
                context.read<HomeCubit>().changeTab(tabIndex: value);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorName.redColor,
              unselectedItemColor: ColorName.greyColor,
              selectedLabelStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: ColorName.redColor,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: ColorName.greyColor,
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.home, color: (context.read<HomeCubit>().state.homeState.data == 0) ? ColorName.redColor : ColorName.greyColor), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.search, color: (context.read<HomeCubit>().state.homeState.data == 1) ? ColorName.redColor : ColorName.greyColor), label: 'Discover'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmarks_rounded, color: (context.read<HomeCubit>().state.homeState.data == 2) ? ColorName.redColor : ColorName.greyColor), label: 'Favourite'),
              ]),
        ),
      );
    });
  }
}
