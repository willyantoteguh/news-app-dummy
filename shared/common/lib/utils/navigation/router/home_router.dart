import 'package:common/utils/navigation/argument/argument.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';

abstract class HomeRouter {
  void goBack({String? arguments});

  void navigateToWebview(WebviewArgument argument);
}

class HomeRouterImpl implements HomeRouter {
  final NavigationHelper navigationHelper;

  HomeRouterImpl({
    required this.navigationHelper,
  });

  @override
  void goBack({String? arguments}) => navigationHelper.pop(arguments);

  @override
  void navigateToWebview(WebviewArgument argument) => navigationHelper.pushNamed(AppRoutes.article, arguments: argument);
}
