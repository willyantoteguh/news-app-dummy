import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';

abstract class HomeRouter {
  void goBack({String? arguments});

  void navigateToHeadline();

  // void navigateToBisnis();

  // void navigateToHiburan();

  // void navigateToKesehatan();

  // void navigateToOlahraga();
}

class HomeRouterImpl implements HomeRouter {
  final NavigationHelper navigationHelper;

  HomeRouterImpl({
    required this.navigationHelper,
  });

  @override
  void goBack({String? arguments}) => navigationHelper.pop(arguments);

  @override
  void navigateToHeadline() => navigationHelper.pushNamed(AppRoutes.home);

  // @override
  // void navigateToBisnis() => navigationHelper.pushNamed(AppRoutes.bisnis);

  // @override
  // void navigateToHiburan() => navigationHelper.pushNamed(AppRoutes.hiburan);

  // @override
  // void navigateToKesehatan() => navigationHelper.pushNamed(AppRoutes.kesehatan);

  // @override
  // void navigateToOlahraga() => navigationHelper.pushNamed(AppRoutes.olahraga);
}
