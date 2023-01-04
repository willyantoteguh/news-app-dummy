import 'dart:developer';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home/domains/entity/request/home_request_entity.dart';
import 'package:home/domains/entity/response/article_entity.dart';
import 'package:home/domains/usecase/get_headline_news.dart';
import 'package:home_feature/presentation/headline_bloc/headline_state.dart';

class HeadlineCubit extends Cubit<HeadlineState> {
  final GetHeadlineNewsUseCase getHeadlineNewsUseCase;

  HeadlineCubit({required this.getHeadlineNewsUseCase})
      : super(
          HeadlineState(
            headlineState: ViewData.initial(),
          ),
        );

  void getHeadline(HomeRequestEntity params) async {
    emit(
      state.copyWith(
        headlineState: ViewData.loading(message: 'Loading..'),
      ),
    );

    final result = await getHeadlineNewsUseCase.call(params);

    return result.fold((failure) => _onFailureGetHeadline(failure), (data) => _onSuccessGetHeadline(data));
  }

  void _onFailureGetHeadline(FailureResponse failure) async {
    emit(
      state.copyWith(
        headlineState: ViewData.error(message: 'Error', failure: failure),
      ),
    );
  }

  void _onSuccessGetHeadline(List<ArticleEntity> data) async {
    emit(
      state.copyWith(
        headlineState: ViewData.loaded(
          data: data,
        ),
      ),
    );

    log("_onSuccess: ${data.map((e) => e.title).toList().toString()}");
  }
}
