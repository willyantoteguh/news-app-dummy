import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

import '../entity/response/article_entity.dart';
import '../repository/home_repository.dart';

class DeleteFavoriteNewsUseCase extends UseCase<dynamic, ArticleEntity> {
  final HomeRepository homeRepository;

  DeleteFavoriteNewsUseCase({required this.homeRepository});

  @override
  Future<Either<FailureResponse, dynamic>> call(ArticleEntity params) async => await homeRepository.deleteFavorite(params);
}
