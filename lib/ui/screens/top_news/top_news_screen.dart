import 'dart:math';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card_presenter.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

class TopNewsScreen extends StatelessWidget {
  final scrollController = ScrollController();

  TopNewsScreen(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<TopNewsPresenter>(context);
    final initialData = presenter.initialData;
    final stream = presenter.stream;
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
            key: key,
            slivers: <Widget>[
              TitleAppBar(title: 'Новости'),
              CupertinoSliverRefreshControl(
                builder: buildSimpleRefreshIndicator,
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 2), () {});
                },
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 8),
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
        });
  }
}

Widget buildSimpleRefreshIndicator(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: refreshState == RefreshIndicatorMode.drag
          ? Opacity(
              opacity: opacityCurve.transform(min(pulledExtent / refreshTriggerPullDistance, 1.0)),
              child: Icon(
                CupertinoIcons.down_arrow,
                color: CupertinoDynamicColor.resolve(CupertinoColors.white, context),
                size: 36.0,
              ),
            )
          : Opacity(
              opacity: opacityCurve.transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
              child: const CupertinoActivityIndicator(radius: 14.0),
            ),
    ),
  );
}
