import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:clean_news_ai/ui/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card_presenter.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

class TopNewsScreen extends StatelessWidget {
  TopNewsScreen(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialData = PresenterProvider.of<TopNewsPresenter>(context).initialData;
    final stream = PresenterProvider.of<TopNewsPresenter>(context).stream;
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: key,
      slivers: <Widget>[
        TitleAppBar(title: 'Новости'),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2), () {});
          },
        ),
        StreamBuilder(
          stream: stream,
          initialData: initialData,
          builder: (ctx, AsyncSnapshot<List<Article>> snapshot) {
            return SliverList(
              delegate: SliverChildListDelegate(snapshot.data.map((article) {
                final presenter = NewsCardPresenter(article);
                return PresenterProvider<Store<AppState>, NewsCardPresenter>(
                    key: ValueKey(article.url), presenter: presenter, child: NewsCard());
              }).toList()),
            );
          },
        )
      ],
    );
  }
}
