import 'package:common/utils/navigation/argument/home_argument/home_argument.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';

abstract class HomeRouter {
  void goBack({String? arguments});

  void navigateToHome();
}

class HomeRouterImpl implements HomeRouter {
  final NavigationHelper navigationHelper;

  HomeRouterImpl({
    required this.navigationHelper,
  });

  @override
  void goBack({String? arguments}) => navigationHelper.pop(arguments);

  @override
  void navigateToHome() => navigationHelper.pushReplacementNamed(AppRoutes.home);
}
