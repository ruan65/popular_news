import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/state/base_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/util/comparable_wrapper.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/task.dart';

import '../event_enum.dart';

class NewsMiddleware extends Middleware<Store<AppState>> {
  List<Task<List<Article>>> refreshingTasks = [];

  bool getTopNews(Event<BaseState> event) {
    void _fetchEvents(List<Article> models) {
      final mapOfModels =
          Map<String, Article>.fromIterable(models, key: (item) => item.url, value: (item) => item);
      if (ComparableWrapper(store.state.topNewsState.news) != ComparableWrapper(mapOfModels)) {
        store.dispatchEvent(
            event: Event.modify(
          reducer: (state, _) => state.topNewsState..addNews(mapOfModels),
        ));
      }
    }

    if (event.type == EventType.fetchNews) {
      if (refreshingTasks.isNotEmpty) {
        refreshingTasks.forEach((task) {
          Executor().removeTask(task: task);
        });
        refreshingTasks.clear();
      }
      final tasks = (event.bundle as Set<String>)
          .map((theme) =>
              Task<List<Article>>(function: DomainRepository.getTopArticles, bundle: theme))
          .toList();
      tasks.forEach((task) {
        Executor().addTask<List<Article>>(task: task).listen(_fetchEvents);
      });
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [getTopNews];
}
