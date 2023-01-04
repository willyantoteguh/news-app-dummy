import 'package:common/utils/state/view_data_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class HiburanState {
  final ViewData<List<ArticleEntity>> hiburanState;

  const HiburanState({required this.hiburanState});

  HiburanState copyWith({ViewData<List<ArticleEntity>>? hiburanState}) {
    return HiburanState(hiburanState: hiburanState ?? this.hiburanState);
  }
}
