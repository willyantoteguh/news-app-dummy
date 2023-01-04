import 'dart:developer';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/usecase/get_hiburan_news.dart';
import 'package:home/domains/usecase/get_kesehatan_news.dart';

import 'kesehatan_state.dart';

class KesehatanCubit extends Cubit<KesehatanState> {
  final GetKesehatanNewsUseCase getKesehatanNewsUseCase;

  KesehatanCubit({required this.getKesehatanNewsUseCase})
      : super(
          KesehatanState(
            kesehatanState: ViewData.initial(),
          ),
        );

  void getKesehatan(HomeRequestEntity params) async {
    emit(
      state.copyWith(
        kesehatanState: ViewData.loading(message: 'Loading..'),
      ),
    );

    final result = await getKesehatanNewsUseCase.call(params);

    return result.fold((failure) => _onFailure(failure), (data) => _onSuccess(data));
  }

  void _onFailure(FailureResponse failure) async {
    emit(
      state.copyWith(
        kesehatanState: ViewData.error(message: 'Error', failure: failure),
      ),
    );
  }

  void _onSuccess(List<ArticleEntity> data) async {
    emit(
      state.copyWith(
        kesehatanState: ViewData.loaded(
          data: data,
        ),
      ),
    );

    log("_onSuccessKesehatan: ${data.map((e) => e.title).toList().toString()}");
  }
}
