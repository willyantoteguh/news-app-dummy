import 'dart:developer';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/usecase/get_hiburan_news.dart';
import 'package:home/domains/usecase/get_kesehatan_news.dart';
import 'package:home/domains/usecase/get_olahraga_news.dart';

import 'olahraga_state.dart';

class OlahragaCubit extends Cubit<OlahragaState> {
  final GetOlahragaNewsUseCase getOlahragaNewsUseCase;

  OlahragaCubit({required this.getOlahragaNewsUseCase})
      : super(
          OlahragaState(
            olahragaState: ViewData.initial(),
          ),
        );

  void getOlahraga(HomeRequestEntity params) async {
    emit(
      state.copyWith(
        olahragaState: ViewData.loading(message: 'Loading..'),
      ),
    );

    final result = await getOlahragaNewsUseCase.call(params);

    return result.fold((failure) => _onFailure(failure), (data) => _onSuccess(data));
  }

  void _onFailure(FailureResponse failure) async {
    emit(
      state.copyWith(
        olahragaState: ViewData.error(message: 'Error', failure: failure),
      ),
    );
  }

  void _onSuccess(List<ArticleEntity> data) async {
    emit(
      state.copyWith(
        olahragaState: ViewData.loaded(
          data: data,
        ),
      ),
    );

    log("_onSuccessKesehatan: ${data.map((e) => e.title).toList().toString()}");
  }
}
