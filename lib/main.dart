import 'package:clean_news_ai/data/dto/source.dart';
import 'package:clean_news_ai/domain/components/top_news/events/top_news_events.dart';
import 'package:clean_news_ai/ui/screens/base_screen.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_presenter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:osam/osam.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_manager/executor.dart';
import 'data/dto/article.dart';
import 'domain/components/app/state/app_state.dart';
import 'domain/components/favorites/state/favorites_state.dart';
import 'domain/components/navigation/state/navigation_state.dart';
import 'domain/components/settings/state/settings_state.dart';
import 'domain/components/top_news/middleware/top_news_middleware.dart';
import 'domain/components/top_news/state/top_news_state.dart';
const isolatePoolSize = 2;

Future<void> registerAdapters() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(AppStateAdapter(), 0);
  Hive.registerAdapter(TopNewsStateAdapter(), 1);
  Hive.registerAdapter(FavoritesStateAdapter(), 2);
  Hive.registerAdapter(SettingsStateAdapter(), 3);
  Hive.registerAdapter(NavigationStateAdapter(), 4);
  Hive.registerAdapter(ArticleAdapter(), 5);
  Hive.registerAdapter(SourceAdapter(), 6);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Executor(isolatePoolSize: isolatePoolSize).warmUp();
  await registerAdapters();
  final store = Store(AppState(), middleWares: <Middleware<Store<AppState>>>[NewsMiddleware()]);
  await store.initPersist();
  store.restoreState();
  store.dispatchEvent(event: FetchNewsEvent());
  final initialIndex = store.state.navigationState.navigationIndex;
  runApp(MaterialApp(
      home: StoreProvider(
          key: ValueKey('Store'),
          store: store,
          child: PresenterProvider<NavigationPresenter>(
              key: ValueKey('navigation'),
              presenter: NavigationPresenter(),
              child: BaseScreen(
                initialIndex: initialIndex,
              )))));
}
