import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

import '../entity/response/article_entity.dart';
import '../repository/home_repository.dart';

class GetAllFavoriteNewsUseCase extends UseCase<List<ArticleEntity>, NoParams> {
  final HomeRepository homeRepository;

  GetAllFavoriteNewsUseCase({required this.homeRepository});

  @override
  Future<Either<FailureResponse, List<ArticleEntity>>> call(NoParams params) async => await homeRepository.getAllFavorite();
}
