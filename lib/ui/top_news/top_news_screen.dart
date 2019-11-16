import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:clean_news_ai/ui/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/ui_elements/articles_list.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

class TopNewsScreen extends StatelessWidget {
  TopNewsScreen(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: key,
      slivers: <Widget>[
        TitleAppBar(title: 'Новости', key: ValueKey('news')),
        CupertinoSliverRefreshControl(
          key: ValueKey('refreshControl'),
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2), () {});
          },
        ),
        PresenterProvider<Store<AppState>, TopNewsPresenter>(
          presenter: TopNewsPresenter(),
          child: ArticleList(
            key: ValueKey('newsList'),
          ),
        )
      ],
    );
  }
}
