
import 'package:clean_news_ai/screens/abstracts/abstract_state.dart';

abstract class AbstractMutator {
  final AbstractState state;
  const AbstractMutator({this.state});

  getNews() {}

  updateStars({String url}) {
    if (state.news.containsKey(url)) {
      state.news[url].liked = !state.news[url].liked;
      state.broadcaster.add(state.news);
    }
  }
}
