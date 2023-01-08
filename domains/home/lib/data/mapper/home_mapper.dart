import 'package:home/data/models/request/home_request_dto.dart';
import 'package:home/data/models/response/home_response_dto.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class HomeMapper {
  ArticleEntity mapHomeArticleDtoToArticleEntity(Article articleDto) {
    return ArticleEntity(
        author: articleDto.author ?? '',
        title: articleDto.title ?? '',
        description: articleDto.description ?? '',
        url: articleDto.url ?? '',
        urlToImage: articleDto.urlToImage ?? '',
        publishedAt: articleDto.publishedAt ?? '',
        content: articleDto.content ?? '');
  }

  List<ArticleEntity> mapListArticleDtoToEntity(List<Article>? listArticleDto) {
    final listArticleEntity = <ArticleEntity>[];

    for (Article itemArticleDto in listArticleDto!) {
      listArticleEntity.add(mapHomeArticleDtoToArticleEntity(itemArticleDto));
    }

    return listArticleEntity;
  }

  HomeRequestDto mapHomeRequestEntityToHomeRequestDto(HomeRequestEntity homeRequestEntity) => HomeRequestDto(
        q: homeRequestEntity.q,
        category: homeRequestEntity.category,
        language: homeRequestEntity.language,
        pageSize: homeRequestEntity.pageSize,
        page: homeRequestEntity.page,
      );

  ArticleEntity mapArticleDtoToArticleEntity(Article article) {
    return ArticleEntity(
        author: article.author ?? '',
        title: article.title ?? '',
        description: article.description ?? '',
        url: article.url ?? '',
        urlToImage: article.urlToImage ?? '',
        publishedAt: article.publishedAt ?? '',
        content: article.content ?? '');
  }
}
