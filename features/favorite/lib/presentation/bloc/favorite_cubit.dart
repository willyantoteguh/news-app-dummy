import 'dart:developer';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:favorite/presentation/bloc/favorite_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/usecase/delete_favorite_news.dart';
import 'package:home/domains/usecase/get_all_favorite_news.dart';
import 'package:home/domains/usecase/store_favorite_news.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final StoreFavoriteNewsUseCase storeFavoriteNewsUseCase;
  final DeleteFavoriteNewsUseCase deleteFavoriteNewsUseCase;
  final GetAllFavoriteNewsUseCase getAllFavoriteNewsUseCase;

  FavoriteCubit({
    required this.storeFavoriteNewsUseCase,
    required this.deleteFavoriteNewsUseCase,
    required this.getAllFavoriteNewsUseCase,
  }) : super(
          FavoriteState(
            addFavorite: ViewData.initial(),
            deleteFavorite: ViewData.initial(),
            allDataFavorite: ViewData.initial(),
          ),
        );

  void addToFavorite(ArticleEntity articleEntity) async {
    emit(state.copyWith(addFavorite: ViewData.loading(message: 'Loading..')));

    final result = await storeFavoriteNewsUseCase.call(articleEntity);
    log('result..');

    return result.fold((failure) => _onFailureFavorite(failure), (data) => _onSuccessFavorite(data));
  }

  void _onFailureFavorite(FailureResponse failure) {
    emit(state.copyWith(addFavorite: ViewData.error(message: 'Error', failure: failure)));
    log("failure message");
  }

  void _onSuccessFavorite(data) {
    emit(
      state.copyWith(
        addFavorite: ViewData.loaded(data: data),
        isFavorite: true,
      ),
    );

    log("onSuccessFav: ${data.toString()}");
  }

  void deleteFavorite(ArticleEntity articleEntity) async {
    emit(state.copyWith(deleteFavorite: ViewData.loading(message: 'Delete Processing')));

    final result = await deleteFavoriteNewsUseCase.call(articleEntity);
    log('result delete..');

    return result.fold((failure) => _onFailureDeleteFavorite(failure), (data) => _onSuccessDeleteFavorite(data));
  }

  void _onFailureDeleteFavorite(FailureResponse failure) {
    emit(state.copyWith(deleteFavorite: ViewData.error(message: 'Error', failure: failure)));
    log("failure message");
  }

  void _onSuccessDeleteFavorite(data) {
    emit(
      state.copyWith(
        deleteFavorite: ViewData.loaded(data: data),
        isFavorite: false,
      ),
    );

    log("onSuccessFav: ${data.toString()}");
  }

  void allDataFavorite() async {
    emit(state.copyWith(allDataFavorite: ViewData.loading(message: 'Loading')));

    final result = await getAllFavoriteNewsUseCase.call(const NoParams());
    log('get all result');

    return result.fold((failure) => _onFailureAllFavorite(failure), (data) => _onSuccessAllFavorite(data));
  }

  void _onFailureAllFavorite(FailureResponse failure) {
    emit(state.copyWith(allDataFavorite: ViewData.error(message: 'Error list', failure: failure)));
    log('failure message');
  }

  void _onSuccessAllFavorite(List<ArticleEntity> data) {
    emit(
      state.copyWith(allDataFavorite: ViewData.loaded(data: data), isFavorite: true),
    );

    log("onSuccessAllFav: ${data.map((e) => e.title).toList().toString()}");
  }
}
