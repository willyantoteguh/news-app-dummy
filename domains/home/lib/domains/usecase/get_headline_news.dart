import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/repository/home_repository.dart';

class GetHeadlineNewsUseCase extends UseCase<List<ArticleEntity>, HomeRequestEntity> {
  final HomeRepository homeRepository;

  const GetHeadlineNewsUseCase({required this.homeRepository});

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> call(HomeRequestEntity params) => homeRepository.getAllNews(homeRequestEntity: params);
}
