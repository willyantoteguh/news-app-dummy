import 'package:dependencies/get_it/get_it.dart';
import 'package:home/data/mapper/home_mapper.dart';
import 'package:home/data/source/local/home_local_datasource.dart';
import 'package:home/domains/repository/home_repository.dart';
import 'package:home/domains/usecase/delete_favorite_news.dart';
import 'package:home/domains/usecase/get_all_favorite_news.dart';
import 'package:home/domains/usecase/get_bisnis_news.dart';
import 'package:home/domains/usecase/get_headline_news.dart';
import 'package:home/domains/usecase/get_hiburan_news.dart';
import 'package:home/domains/usecase/get_kesehatan_news.dart';
import 'package:home/domains/usecase/get_olahraga_news.dart';
import 'package:home/domains/usecase/store_favorite_news.dart';

import '../data/repository/home_repository_impl.dart';
import '../data/source/remote/home_remote_datasource.dart';

class HomeDependency {
  HomeDependency() {
    _registerRemoteDataSource();
    _registerLocalDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCase();
  }

  _registerRemoteDataSource() => sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(
          dio: sl(),
        ),
      );

  _registerLocalDataSource() => sl.registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSourceImpl(),
      );

  _registerMapper() => sl.registerLazySingleton<HomeMapper>(
        () => HomeMapper(),
      );

  _registerRepository() => sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
          mapper: sl(),
          homeRemoteDataSource: sl(),
          homeLocalDataSource: sl(),
        ),
      );

  _registerUseCase() {
    sl.registerLazySingleton<GetHeadlineNewsUseCase>(
      () => GetHeadlineNewsUseCase(
        homeRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetBisnisNewsUseCase>(
      () => GetBisnisNewsUseCase(
        homeRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetHiburanNewsUseCase>(
      () => GetHiburanNewsUseCase(
        homeRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetKesehatanNewsUseCase>(
      () => GetKesehatanNewsUseCase(
        homeRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetOlahragaNewsUseCase>(
      () => GetOlahragaNewsUseCase(
        homeRepository: sl(),
      ),
    );
    sl.registerLazySingleton<StoreFavoriteNewsUseCase>(
      () => StoreFavoriteNewsUseCase(
        homeRepository: sl(),
      ),
    );
    sl.registerLazySingleton<DeleteFavoriteNewsUseCase>(
      () => DeleteFavoriteNewsUseCase(
        homeRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetAllFavoriteNewsUseCase>(
      () => GetAllFavoriteNewsUseCase(
        homeRepository: sl(),
      ),
    );
  }
}
