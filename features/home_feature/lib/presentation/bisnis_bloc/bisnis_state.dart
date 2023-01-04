import 'package:common/utils/state/view_data_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class BisnisState {
  final ViewData<List<ArticleEntity>> bisnisState;

  const BisnisState({required this.bisnisState});

  BisnisState copyWith({ViewData<List<ArticleEntity>>? bisnisState}) {
    return BisnisState(bisnisState: bisnisState ?? this.bisnisState);
  }
}
