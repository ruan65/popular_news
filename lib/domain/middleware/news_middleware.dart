import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/state/base_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/util/comparable_wrapper.dart';
import 'package:osam/util/event.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/task.dart';

import '../event_enum.dart';

class NewsMiddleware extends Middleware {
  Task<List<ArticleModel>> refreshingTask;

  bool getTopNews(Store store, Event<BaseState> event) {
    void _fetchEvents(List<ArticleModel> models) {
      final mapOfModels = Map<String, ArticleModel>.fromIterable(models,
          key: (item) => item.article.url, value: (item) => item);
      if (ComparableWrapper(store.getState<TopNewsState>().news) !=
          ComparableWrapper(mapOfModels)) {
        store.dispatchEvent<TopNewsState>(
            event: Event.modify(reducerCaller: (state) => state.addNews(mapOfModels)));
      }
    }

    if (event.type == EventType.fetchNews) {
      if (refreshingTask != null) Executor().removeTask(task: refreshingTask);
      refreshingTask = Task(function: DomainRepository.getTopArticles, bundle: event.bundle);
      Executor()
          .addTask<List<ArticleModel>>(task: refreshingTask)
          .map((models) => models
              .map((model) => model..isSaved = DomainRepository().isFavorite(model.article))
              .toList())
          .listen(_fetchEvents);
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [getTopNews];
}
