import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:home/data/mapper/home_mapper.dart';
import 'package:home/data/source/remote/home_remote_datasource.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:home/domains/repository/home_repository.dart';

import '../../domains/entity/request/home_request_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeMapper mapper;

  HomeRepositoryImpl({required this.homeRemoteDataSource, required this.mapper});

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> getAllNews({required HomeRequestEntity homeRequestEntity}) async {
    try {
      final response = await homeRemoteDataSource.getAllNews(
        homeRequestDto: mapper.mapHomeRequestEntityToHomeRequestDto(homeRequestEntity),
      );

      return Right(mapper.mapListArticleDtoToEntity(response.articles));
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> getBisnisNews({required HomeRequestEntity homeRequestEntity}) async {
    try {
      final response = await homeRemoteDataSource.getNewsByCategory(
        homeRequestDto: mapper.mapHomeRequestEntityToHomeRequestDto(homeRequestEntity),
      );

      return Right(mapper.mapListArticleDtoToEntity(response.articles));
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> getHiburanNews({required HomeRequestEntity homeRequestEntity}) async {
    try {
      final response = await homeRemoteDataSource.getNewsByCategory(
        homeRequestDto: mapper.mapHomeRequestEntityToHomeRequestDto(homeRequestEntity),
      );

      return Right(mapper.mapListArticleDtoToEntity(response.articles));
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> getKesehatanNews({required HomeRequestEntity homeRequestEntity}) async {
    try {
      final response = await homeRemoteDataSource.getNewsByCategory(
        homeRequestDto: mapper.mapHomeRequestEntityToHomeRequestDto(homeRequestEntity),
      );

      return Right(mapper.mapListArticleDtoToEntity(response.articles));
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> getOlahragaNews({required HomeRequestEntity homeRequestEntity}) async {
    try {
      final response = await homeRemoteDataSource.getNewsByCategory(
        homeRequestDto: mapper.mapHomeRequestEntityToHomeRequestDto(homeRequestEntity),
      );

      return Right(mapper.mapListArticleDtoToEntity(response.articles));
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }
}
