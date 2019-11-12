import 'package:clean_news_ai/domain/event_enum.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/states/settings_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/state/base_state.dart';
import 'package:osam/util/event.dart';

class SettingsMiddleware extends Middleware {
  bool changeTheme(Event<BaseState> event) {
    if (event.type == EventType.changeTheme) {
      DomainRepository().changeTheme(event.bundle);
      store.dispatchEvent<SettingsState>(event: Event.sideEffect(type: EventType.fetchSettings));
    }
    return nextEvent(true);
  }

  bool fetchSettings(Event<BaseState> event) {
    if (event.type == EventType.fetchSettings) {
      final currentTheme = DomainRepository().currentTheme();
      store.dispatchEvent<SettingsState>(
          event: Event.modify(reducerCaller: (state, _) => state.changeTheme(currentTheme)));
      if (store.getState<TopNewsState>().news.isNotEmpty) {
        store.dispatchEvent<TopNewsState>(event: Event.sideEffect(type: EventType.clearNews));
      }
      store.dispatchEvent<TopNewsState>(
          event: Event.sideEffect(type: EventType.fetchNews, bundle: currentTheme));
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [changeTheme, fetchSettings];
}
