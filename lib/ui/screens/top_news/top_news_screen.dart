import 'dart:math';

import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card_presenter.dart';
import 'package:clean_news_ai/ui/widgets/news_sticky_header.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:osam/osam.dart';

class TopNewsScreen extends StatefulWidget {
  TopNewsScreen(Key key) : super(key: key);

  @override
  _TopNewsScreenState createState() => _TopNewsScreenState();
}

class _TopNewsScreenState extends State<TopNewsScreen> {
  final scrollController = ScrollController();

  final listWithSlivers = <SliverStickyHeader>[];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final presenter = PresenterProvider.of<TopNewsPresenter>(context);
      presenter.stream.listen((data) {
        setState(() {
          listWithSlivers.clear();
          listWithSlivers.addAll(data.keys
              .map((key) => SliverStickyHeader(
                    header: NewsStickyHeader(
                      title: key[0].toUpperCase() + key.substring(1, key.length),
                    ),
                    sliver: SliverAnimatedList(
                      initialItemCount: data[key].values.length,
                      itemBuilder: (ctx, index, animation) {
                        return PresenterProvider<Store<AppState>, NewsCardPresenter>(
                            key: ValueKey(data[key].values.toList()[index].url),
                            presenter: NewsCardPresenter(data[key].values.toList()[index]),
                            child: NewsCard());
                      },
                    ),
                  ))
              .toList());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<TopNewsPresenter>(context);
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
            key: widget.key,
            slivers: <Widget>[
              TitleAppBar(title: 'News'),
              CupertinoSliverRefreshControl(
                builder: buildSimpleRefreshIndicator,
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 2), () {});
                },
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 8),
              ),
              ...listWithSlivers
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
