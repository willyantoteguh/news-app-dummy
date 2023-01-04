import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

import '../entity/request/home_request_entity.dart';
import '../entity/response/article_entity.dart';
import '../repository/home_repository.dart';

class GetBisnisNewsUseCase extends UseCase<List<ArticleEntity>, HomeRequestEntity> {
  final HomeRepository homeRepository;

  const GetBisnisNewsUseCase({required this.homeRepository});

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> call(HomeRequestEntity params) => homeRepository.getBisnisNews(homeRequestEntity: params);
}
