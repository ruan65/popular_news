import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/state/base_state.dart';
import 'package:osam/util/comparable_wrapper.dart';
import 'package:osam/util/event.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/task.dart';

import '../event_enum.dart';

class NewsMiddleware extends Middleware {
  Task<List<Article>> refreshingTask;

  bool getTopNews(Event<BaseState> event) {
    void _fetchEvents(List<Article> models) {
      final mapOfModels =
          Map<String, Article>.fromIterable(models, key: (item) => item.url, value: (item) => item);
      if (ComparableWrapper(store.getState<TopNewsState>().news) !=
          ComparableWrapper(mapOfModels)) {
        store.dispatchEvent<TopNewsState>(
            event: Event.modify(
          reducerCaller: (state, _) => state.addNews(mapOfModels),
        ));
      }
    }

    if (event.type == EventType.fetchNews) {
      if (refreshingTask != null) Executor().removeTask(task: refreshingTask);
      refreshingTask = Task(function: DomainRepository.getTopArticles, bundle: event.bundle);
      Executor().addTask<List<Article>>(task: refreshingTask).listen(_fetchEvents);
    }
    return nextEvent(true);
  }

  bool clearNews(Event<BaseState> event) {
    if (event.type == EventType.clearNews) {
      store.dispatchEvent<TopNewsState>(
          event: Event.modify(
        reducerCaller: (state, _) => state.cleanNews(),
      ));
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [getTopNews, clearNews];
}
