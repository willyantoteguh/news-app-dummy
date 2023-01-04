import 'dart:developer';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/usecase/get_bisnis_news.dart';

import 'bisnis_state.dart';

class BisnisCubit extends Cubit<BisnisState> {
  final GetBisnisNewsUseCase getBisnisNewsUseCase;

  BisnisCubit({required this.getBisnisNewsUseCase})
      : super(
          BisnisState(
            bisnisState: ViewData.initial(),
          ),
        );

  void getBisnis(HomeRequestEntity params) async {
    emit(
      state.copyWith(
        bisnisState: ViewData.loading(message: 'Loading..'),
      ),
    );

    final result = await getBisnisNewsUseCase.call(params);

    return result.fold((failure) => _onFailure(failure), (data) => _onSuccess(data));
  }

  void _onFailure(FailureResponse failure) async {
    emit(
      state.copyWith(
        bisnisState: ViewData.error(message: 'Error', failure: failure),
      ),
    );
  }

  void _onSuccess(List<ArticleEntity> data) async {
    emit(
      state.copyWith(
        bisnisState: ViewData.loaded(
          data: data,
        ),
      ),
    );

    log("_onSuccessBisnis: ${data.map((e) => e.title).toList().toString()}");
  }
}
