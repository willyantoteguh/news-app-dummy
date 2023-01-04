import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
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
}
