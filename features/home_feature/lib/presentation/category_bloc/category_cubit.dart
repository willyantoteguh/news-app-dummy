import 'dart:developer';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/usecase/get_bisnis_news.dart';
import 'package:home/domains/usecase/get_headline_news.dart';
import 'package:home/domains/usecase/get_hiburan_news.dart';
import 'package:home/domains/usecase/get_kesehatan_news.dart';
import 'package:home/domains/usecase/get_olahraga_news.dart';

import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetHeadlineNewsUseCase getHeadlineNewsUseCase;
  final GetBisnisNewsUseCase getBisnisNewsUseCase;
  final GetHiburanNewsUseCase getHiburanNewsUseCase;
  final GetKesehatanNewsUseCase getKesehatanNewsUseCase;
  final GetOlahragaNewsUseCase getOlahragaNewsUseCase;

  CategoryCubit({
    required this.getHeadlineNewsUseCase,
    required this.getBisnisNewsUseCase,
    required this.getHiburanNewsUseCase,
    required this.getKesehatanNewsUseCase,
    required this.getOlahragaNewsUseCase,
  }) : super(
          CategoryState(
            semuaState: ViewData.initial(),
            bisnisState: ViewData.initial(),
            hiburanState: ViewData.initial(),
            kesehatanState: ViewData.initial(),
            olahragaState: ViewData.initial(),
          ),
        );
  //// SEMUA NEWS
  void getSemua() async {
    HomeRequestEntity params = HomeRequestEntity(q: '', language: 'id', pageSize: 10, page: 1);
    emit(state.copyWith(semuaState: ViewData.loading(message: 'All News Loading....')));

    final result = await getHeadlineNewsUseCase.call(params);

    return result.fold((failure) => _onFailureSemua(failure), (data) => _onSuccessSemua(data));
  }

  void _onFailureSemua(FailureResponse failure) async {
    emit(state.copyWith(semuaState: ViewData.error(message: 'Error', failure: failure)));
  }

  void _onSuccessSemua(List<ArticleEntity> data) async {
    emit(state.copyWith(semuaState: ViewData.loaded(data: data)));

    log("_onSuccessSemua: ${data.map((e) => e.title).toList().toString()}");
  }

  //// BISNIS NEWS
  void getBisnis(HomeRequestEntity params) async {
    emit(state.copyWith(bisnisState: ViewData.loading(message: 'Loading..')));

    final result = await getBisnisNewsUseCase.call(params);

    return result.fold((failure) => _onFailureBisnis(failure), (data) => _onSuccessBisnis(data));
  }

  void _onFailureBisnis(FailureResponse failure) async {
    emit(state.copyWith(bisnisState: ViewData.error(message: 'Error', failure: failure)));
  }

  void _onSuccessBisnis(List<ArticleEntity> data) async {
    emit(state.copyWith(bisnisState: ViewData.loaded(data: data)));

    log("_onSuccessBisnis: ${data.map((e) => e.title).toList().toString()}");
  }

  //// HIBURAN NEWS
  void getHiburan() async {
    emit(state.copyWith(hiburanState: ViewData.loading(message: 'Loading..')));

    HomeRequestEntity params = HomeRequestEntity(q: 'hiburan', language: 'id', pageSize: 10, page: 1);
    final result = await getHiburanNewsUseCase.call(params);

    return result.fold((failure) => _onFailureHiburan(failure), (data) => _onSuccessHiburan(data));
  }

  void _onFailureHiburan(FailureResponse failure) async {
    emit(state.copyWith(hiburanState: ViewData.error(message: 'Error', failure: failure)));
  }

  void _onSuccessHiburan(List<ArticleEntity> data) async {
    emit(state.copyWith(hiburanState: ViewData.loaded(data: data)));

    log("_onSuccessHiburan: ${data.map((e) => e.title).toList().toString()}");
  }

  //// KESEHATAN NEWS
  void getKesehatan() async {
    emit(state.copyWith(kesehatanState: ViewData.loading(message: 'Loading..')));

    HomeRequestEntity params = HomeRequestEntity(q: 'kesehatan', language: 'id', pageSize: 10, page: 1);
    final result = await getKesehatanNewsUseCase.call(params);

    return result.fold((failure) => _onFailureKesehatan(failure), (data) => _onSuccessKesehatan(data));
  }

  void _onFailureKesehatan(FailureResponse failure) async {
    emit(state.copyWith(kesehatanState: ViewData.error(message: 'Error', failure: failure)));
  }

  void _onSuccessKesehatan(List<ArticleEntity> data) async {
    emit(state.copyWith(kesehatanState: ViewData.loaded(data: data)));

    log("_onSuccessKesehatan: ${data.map((e) => e.title).toList().toString()}");
  }

  //// OLAHRAGA NEWS
  void getOlahraga() async {
    emit(state.copyWith(olahragaState: ViewData.loading(message: 'Loading..')));

    HomeRequestEntity params = HomeRequestEntity(q: 'olahraga', language: 'id', pageSize: 10, page: 1);
    final result = await getOlahragaNewsUseCase.call(params);

    return result.fold((failure) => _onFailureOlahraga(failure), (data) => _onSuccessOlahraga(data));
  }

  void _onFailureOlahraga(FailureResponse failure) async {
    emit(state.copyWith(olahragaState: ViewData.error(message: 'Error', failure: failure)));
  }

  void _onSuccessOlahraga(List<ArticleEntity> data) async {
    emit(state.copyWith(olahragaState: ViewData.loaded(data: data)));

    log("_onSuccessOlahraga: ${data.map((e) => e.title).toList().toString()}");
  }
}
