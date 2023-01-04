import 'package:common/utils/state/view_data_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class OlahragaState {
  final ViewData<List<ArticleEntity>> olahragaState;

  const OlahragaState({required this.olahragaState});

  OlahragaState copyWith({ViewData<List<ArticleEntity>>? olahragaState}) {
    return OlahragaState(olahragaState: olahragaState ?? this.olahragaState);
  }
}
