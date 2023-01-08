import 'package:common/utils/navigation/argument/argument.dart';
import 'package:common/utils/navigation/router/home_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BaseHome {
  final HomeRouter _homeRouter = sl();

  HomeRouter get homeRouter => _homeRouter;

  void toWebview(WebviewArgument argument) => homeRouter.navigateToWebview(argument);
}
