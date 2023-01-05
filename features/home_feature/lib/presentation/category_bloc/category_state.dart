import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class CategoryState {
  final ViewData<List<ArticleEntity>> semuaState;
  final ViewData<List<ArticleEntity>> bisnisState;
  final ViewData<List<ArticleEntity>> hiburanState;
  final ViewData<List<ArticleEntity>> olahragaState;
  final ViewData<List<ArticleEntity>> kesehatanState;

  const CategoryState({
    required this.semuaState,
    required this.bisnisState,
    required this.hiburanState,
    required this.olahragaState,
    required this.kesehatanState,
  });

  CategoryState copyWith({
    ViewData<List<ArticleEntity>>? semuaState,
    ViewData<List<ArticleEntity>>? bisnisState,
    ViewData<List<ArticleEntity>>? hiburanState,
    ViewData<List<ArticleEntity>>? olahragaState,
    ViewData<List<ArticleEntity>>? kesehatanState,
  }) {
    return CategoryState(
      semuaState: semuaState ?? this.semuaState,
      bisnisState: bisnisState ?? this.bisnisState,
      hiburanState: hiburanState ?? this.hiburanState,
      olahragaState: olahragaState ?? this.olahragaState,
      kesehatanState: kesehatanState ?? this.kesehatanState,
    );
  }
}
