import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:clean_news_ai/ui/favorites/favorites_presenter.dart';
import 'package:clean_news_ai/ui/ui_elements/articles_list.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: key,
      slivers: <Widget>[
        TitleAppBar(title: 'Избранное', key: ValueKey('favorites')),
        CupertinoSliverRefreshControl(
          key: ValueKey('refreshControl'),
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2), () {});
          },
        ),
        PresenterProvider<Store<AppState>, FavoritesPresenter>(
          presenter: FavoritesPresenter(),
          child: ArticleList(
            key: ValueKey('favoritesList'),
          ),
        )
      ],
    );
  }
}
