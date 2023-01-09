import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:home/data/models/response/home_response_dto.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';

abstract class HomeRepository {
  const HomeRepository();

  Future<Either<FailureResponse, List<ArticleEntity>>> getAllNews({required HomeRequestEntity homeRequestEntity});

  //// Bisnis
  Future<Either<FailureResponse, List<ArticleEntity>>> getBisnisNews({required HomeRequestEntity homeRequestEntity});

  /// Hiburan
  Future<Either<FailureResponse, List<ArticleEntity>>> getHiburanNews({required HomeRequestEntity homeRequestEntity});

  /// Olahraga
  Future<Either<FailureResponse, List<ArticleEntity>>> getOlahragaNews({required HomeRequestEntity homeRequestEntity});

  /// Kesehatan
  Future<Either<FailureResponse, List<ArticleEntity>>> getKesehatanNews({required HomeRequestEntity homeRequestEntity});

  //// Favorite - save
  Future<Either<FailureResponse, dynamic>> storeFavorite(ArticleEntity articleEntity);

  //// Favorite - delete
  Future<Either<FailureResponse, dynamic>> deleteFavorite(ArticleEntity articleEntity);

  //// Favorite - getListData
  Future<Either<FailureResponse, List<ArticleEntity>>> getAllFavorite();
}
