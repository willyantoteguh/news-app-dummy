import 'dart:developer';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/usecase/get_hiburan_news.dart';

import 'hiburan_state.dart';

class HiburanCubit extends Cubit<HiburanState> {
  final GetHiburanNewsUseCase getHiburanNewsUseCase;

  HiburanCubit({required this.getHiburanNewsUseCase})
      : super(
          HiburanState(
            hiburanState: ViewData.initial(),
          ),
        );

  void getHiburan(HomeRequestEntity params) async {
    emit(
      state.copyWith(
        hiburanState: ViewData.loading(message: 'Loading..'),
      ),
    );

    final result = await getHiburanNewsUseCase.call(params);

    return result.fold((failure) => _onFailure(failure), (data) => _onSuccess(data));
  }

  void _onFailure(FailureResponse failure) async {
    emit(
      state.copyWith(
        hiburanState: ViewData.error(message: 'Error', failure: failure),
      ),
    );
  }

  void _onSuccess(List<ArticleEntity> data) async {
    emit(
      state.copyWith(
        hiburanState: ViewData.loaded(
          data: data,
        ),
      ),
    );

    log("_onSuccessHiburan: ${data.map((e) => e.title).toList().toString()}");
  }
}
