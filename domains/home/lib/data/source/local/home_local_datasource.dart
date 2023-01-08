import 'package:core/local/app_database.dart';
import 'package:dependencies/sembast/sembast.dart';
import 'package:home/data/models/response/home_response_dto.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class HomeLocalDataSource {
  static const String NEWS_STORE_NAME = 'news';

  final _newsStore = intMapStoreFactory.store(NEWS_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Article article) async {
    await _newsStore.add(await _db, article.toJson());
  }

  // Future<List<ArticleEntity>> getAllArticleByTitle() async {
  //   final finder = Finder(sortOrders: [SortOrder('title')]);

  //   final recordSnapshot = await _newsStore.find(await _db, finder: finder);

  //   return recordSnapshot.map((e) {
  //     final article = ArticleEntity.fromJson(e.value);

  //     article.url = e.key;
  //     return article;
  //   }).toList();
  // }
}
