import 'dart:async';
import 'dart:ui';

import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:clean_news_ai/domain/states/base_state.dart';
import 'package:clean_news_ai/domain/states/favorite_news_state.dart';
import 'package:clean_news_ai/domain/states/search_news_state.dart';
import 'package:clean_news_ai/domain/states/settings_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:flutter/foundation.dart';

import 'models/event.dart';
import 'repository/domain_repository.dart';

class Store {
  // ignore: close_sink, close_sinks
  final _dispatcher = StreamController<Event>.broadcast();

  final TopNewsState topNewsState;
  final SearchNewsState _searchNewsState;
  final FavoriteNewsState favoriteNewsState;
  final SettingsState settingsState;

  final _domainRepository = DomainRepository();

  Stream<S> nextState<S>({@required BaseState state}) =>
      state.selfStream.map((state) => state as S).distinct((prev, next) => prev != next);

  void sendEvent({@required Event event}) => _dispatcher.sink.add(event);

  StreamSubscription<List<ArticleModel>> refreshingSubscription;

  Store(this.topNewsState, this._searchNewsState, this.favoriteNewsState, this.settingsState) {
    _dispatcher.stream.listen((event) {
      switch (event.type) {
        case EventType.refreshTopNewsState:
          if (refreshingSubscription != null) refreshingSubscription.cancel();
          refreshingSubscription =
              _domainRepository.refreshArticles(event.bundle as String).listen((models) {
            refreshTopNewsState(models);
          });
          break;
        case EventType.refreshFavoriteNewsState:
          refreshFavoriteNewsState(_domainRepository.getFavoriteArticles());
          break;
        case EventType.addToFavorite:
          final articleModel = event.bundle as ArticleModel;
          addFavorite(articleModel);
          _domainRepository.addArticle(articleModel.article);
          break;
        case EventType.removeFavorite:
          final articleModel = event.bundle as ArticleModel;
          removeFavorite(event.bundle as ArticleModel);
          _domainRepository.removeArticle(articleModel.article);
          break;
        case EventType.changeTheme:
          // TODO: Handle this case.
          break;
        case EventType.changeColor:
          changeColor(event.bundle);
          break;
      }
    });
  }

  void changeColor(Color color) {
    settingsState.color = color;
    settingsState.update();
  }

  void refreshTopNewsState(List<ArticleModel> models) {
    topNewsState.articles.clear();
    topNewsState.articles.addAll(models);
    topNewsState.update();
  }

  void refreshFavoriteNewsState(List<ArticleModel> models) {
    favoriteNewsState.articles.clear();
    favoriteNewsState.articles.addAll(models);
    favoriteNewsState.update();
  }

  void addFavorite(ArticleModel model) {
    topNewsState.articles.firstWhere((article) => article == model).isSaved = true;
    topNewsState.update();
    favoriteNewsState.articles.add(model);
    favoriteNewsState.update();
  }

  void removeFavorite(ArticleModel model) {
    final targetModel =
        topNewsState.articles.firstWhere((article) => article == model, orElse: () => null);
    if (targetModel != null) {
      targetModel.isSaved = false;
      topNewsState.update();
    }
    favoriteNewsState.articles.remove(model);
    favoriteNewsState.update();
  }
}
