import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/components/top_news/events/top_news_events.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/task.dart';

class NewsMiddleware extends Middleware<Store<AppState>> {
  List<Task<String, List<Article>>> refreshingTasks = [];

  bool getTopNews(Event event) {
    void _fetchEvents(String theme, List<Article> models) {
      final mapOfModels = Map<String, Article>.fromIterable(models, key: (item) => item.url, value: (item) => item);
      store.dispatchEvent(
          event: Event.modify(reducer: (state, _) => state.topNewsState..addNews(theme: theme, news: mapOfModels)));
    }

    if (event is FetchNewsEvent) {
      /// killing old tasks
      if (refreshingTasks.isNotEmpty) {
        refreshingTasks.forEach((task) {
          Executor().removeTask(task: task);
        });
        refreshingTasks.clear();
      }

      ///creating tasks
      final tasks = store.state.settingsState.themes
          .map((theme) => Task(function: DomainRepository.getTopArticles, arg: theme))
          .toList();
      tasks.forEach((task) {
        Executor().addTask(task: task).listen((news) {
          _fetchEvents(task.arg, news);
        });
      });
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [getTopNews];
}
