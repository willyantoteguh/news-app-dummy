import 'dart:convert';
import 'dart:developer';

import 'package:core/local/app_database.dart';
import 'package:dependencies/sembast/sembast.dart';
import 'package:home/data/models/response/home_response_dto.dart';

abstract class HomeLocalDataSource {
  const HomeLocalDataSource();

  insert(Article article);
  getAllData();
  Future findByTitle(title);
  Future delete(Article article);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String NEWS_STORE_NAME = 'news';

  final _newsStore = intMapStoreFactory.store(NEWS_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  //// Entity to Dto
  @override
  insert(Article article) async {
    try {
      var item = await _newsStore.add(await _db, article.toJson());
      log('into db');
      return item;
    } catch (e) {
      rethrow;
    }
  }

  //// Dto to Entity
  @override
  getAllData() async {
    final finder = Finder(sortOrders: [SortOrder('title')]);

    final list = await _newsStore.find(await _db, finder: finder);
    List<Article> articles = list.map((e) {
      final article = Article.fromJson(e.value);
      return article;
    }).toList();
    return articles;
  }

  @override
  Future findByTitle(title) async {
    final Finder finder = Finder(filter: Filter.equals('title', title));

    var item = await _newsStore.findFirst(await _db, finder: finder);
    print(item);

    return Article.fromJson(item!.value);
  }

  @override
  Future delete(Article article) async {
    final finder = Finder(filter: Filter.byKey(article.title));
    await _newsStore.delete(
      await _db,
      finder: finder,
    );
  }
}
