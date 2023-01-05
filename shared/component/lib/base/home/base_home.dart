import 'package:common/utils/navigation/router/home_router.dart';
import 'package:dependencies/get_it/get_it.dart';

mixin BaseHome {
  final HomeRouter _homeRouter = sl();

  HomeRouter get homeRouter => _homeRouter;

  void toHeadline() => homeRouter.navigateToHeadline();

  // void toBisnis() => homeRouter.navigateToBisnis();

  // void toHiburan() => homeRouter.navigateToHiburan();

  // void toOlahraga() => homeRouter.navigateToOlahraga();

  // void toKesehatan() => homeRouter.navigateToKesehatan();
}
