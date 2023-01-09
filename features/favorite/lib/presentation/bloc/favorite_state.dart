import 'package:common/utils/state/view_data_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class FavoriteState {
  final ViewData<dynamic> addFavorite;
  final ViewData<dynamic> deleteFavorite;
  final ViewData<List<ArticleEntity>> allDataFavorite;
  final bool isFavorite;

  const FavoriteState({
    required this.addFavorite,
    required this.deleteFavorite,
    required this.allDataFavorite,
    this.isFavorite = false,
  });

  FavoriteState copyWith({
    ViewData<dynamic>? addFavorite,
    ViewData<dynamic>? deleteFavorite,
    ViewData<List<ArticleEntity>>? allDataFavorite,
    bool? isFavorite,
  }) {
    return FavoriteState(
      addFavorite: addFavorite ?? this.addFavorite,
      deleteFavorite: deleteFavorite ?? this.deleteFavorite,
      allDataFavorite: allDataFavorite ?? this.allDataFavorite,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
