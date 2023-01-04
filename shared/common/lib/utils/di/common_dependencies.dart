import 'package:common/utils/navigation/router/home_router.dart';
import 'package:dependencies/get_it/get_it.dart';

import '../navigation/navigation_helper.dart';

class CommonDependencies {
  CommonDependencies() {
    _navigation();
    _routers();
  }

  void _navigation() => sl.registerLazySingleton<NavigationHelper>(
        () => NavigationHelperImpl(),
      );

  void _routers() {
    sl.registerLazySingleton<HomeRouter>(
      () => HomeRouterImpl(
        navigationHelper: sl(),
      ),
    );
  }
}
