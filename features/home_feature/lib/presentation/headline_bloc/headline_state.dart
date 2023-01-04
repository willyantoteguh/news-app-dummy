import 'package:common/utils/state/view_data_state.dart';
import 'package:home/domains/entity/response/article_entity.dart';

class HeadlineState {
  final ViewData<List<ArticleEntity>> headlineState;

  const HeadlineState({required this.headlineState});

  HeadlineState copyWith({ViewData<List<ArticleEntity>>? headlineState}) {
    return HeadlineState(headlineState: headlineState ?? this.headlineState);
  }
}
