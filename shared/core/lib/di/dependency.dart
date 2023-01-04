import 'package:common/utils/flavor/app_flavor.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/get_it/get_it.dart';

import '../network/dio_handler.dart';

class RegisterCoreModule {
  RegisterCoreModule() {
    _register();
  }

  void _register() {
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
    sl.registerLazySingleton<DioHandler>(() => DioHandler(
          apiBaseUrl: Config.baseUrl,
        ));
  }
}
