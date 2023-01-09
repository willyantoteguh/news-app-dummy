import 'dart:developer';

import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:home/data/mapper/home_mapper.dart';
import 'package:home/data/models/response/home_response_dto.dart';
import 'package:home/data/source/local/home_local_datasource.dart';
import 'package:home/data/source/remote/home_remote_datasource.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:home/domains/repository/home_repository.dart';

import '../../domains/entity/request/home_request_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  final HomeMapper mapper;

  HomeRepositoryImpl({required this.homeRemoteDataSource, required this.homeLocalDataSource, required this.mapper});

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

  @override
  Future<Either<FailureResponse, dynamic>> storeFavorite(ArticleEntity articleEntity) async {
    try {
      final data = mapper.mapArticleEntityToArticleDto(articleEntity);
      final response = homeLocalDataSource.insert(data);
      log("from response impl: ${response.toString()}");
      log("data in impl: ${data.toJson().toString()}");
      return Right(response);
    } catch (e) {
      log('failure impl');
      return Left(FailureResponse(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, dynamic>> deleteFavorite(ArticleEntity articleEntity) async {
    try {
      final data = mapper.mapArticleEntityToArticleDto(articleEntity);
      final response = homeLocalDataSource.delete(data);

      return Right(response);
    } catch (e) {
      return Left(FailureResponse(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> getAllFavorite() async {
    try {
      final getList = await homeLocalDataSource.getAllData();
      List<Article> data = getList;
      final response = mapper.mapListArticleDtoToEntity(data);
      log("from all fav impl: ${response.map((e) => e.publishedAt).toList().toString()}");

      return Right(response);
    } catch (e) {
      return Left(FailureResponse(errorMessage: e.toString()));
    }
  }

  // @override
  // storeFavorite({required ArticleEntity articleEntity}) {
  //   mapper.mapArticleEntityToArticleDto(articleEntity);
  // }
}
