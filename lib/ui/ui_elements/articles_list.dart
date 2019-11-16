import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import 'list_element/news_card.dart';

class ArticleList extends StatelessWidget {
  final Presenter<Store<BaseState>> presenter;
  const ArticleList({Key key, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: specify presenter
    final stream = presenter.stream;
    final initialData = presenter.initialData;

    return StreamBuilder(
      key: ValueKey('newsListBuilder'),
      initialData: initialData,
      stream: stream,
      builder: (ctx, AsyncSnapshot<List<Article>> snapshot) {
        return SliverList(
          key: ValueKey('sliverList'),
          delegate: SliverChildListDelegate(snapshot.data
              .map((article) => PresenterProvider<Store<AppState>, NewsCardPresenter>(
                  presenter: NewsCardPresenter(article.url), child: NewsCard(article: article)))
              .toList()),
        );
      },
    );
  }
}
