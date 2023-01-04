import 'package:common/utils/state/view_data_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class KesehatanState {
  final ViewData<List<ArticleEntity>> kesehatanState;

  const KesehatanState({required this.kesehatanState});

  KesehatanState copyWith({ViewData<List<ArticleEntity>>? kesehatanState}) {
    return KesehatanState(kesehatanState: kesehatanState ?? this.kesehatanState);
  }
}
