import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card_presenter.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import 'favorites_presenter.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen(Key key) : super(key: key);
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<FavoritesPresenter>(context);
    return StreamBuilder(
      initialData: presenter.initialScrollPosition,
      builder: (context, AsyncSnapshot<double> snapshot) {
        Future.delayed(Duration.zero, () {
          scrollController.jumpTo(snapshot.data);
        });
        return CustomScrollView(
          controller: scrollController
            ..addListener(() {
              presenter.updateScrollPosition(scrollController.offset);
            }),
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            TitleAppBar(title: 'Favorites'),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 2), () {});
              },
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 8),
            ),
            StreamBuilder(
              stream: presenter.stream,
              initialData: presenter.initialData,
              builder: (ctx, AsyncSnapshot<List<Article>> snapshot) {
                return SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: snapshot.data.length,
                  itemBuilder: (ctx, index, animation) {
                    return PresenterProvider(
                      key: ValueKey(snapshot.data[index]),
                      presenter: NewsCardPresenter(snapshot.data[index]),
                      child: NewsCard(listKey: _listKey, index: index),
                    );
                  },
                );
              },
            )
          ],
        );
      }
    );
  }
}
