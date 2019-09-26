import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:clean_news_ai/ui/bloc_injector.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_bloc.dart';

abstract class Screen extends StatefulWidget {
  Screen({Key key, this.appBar}) : super(key: key);

  final TitleAppBar appBar;

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = BlocInjector.of(context).bloc;
    assert(bloc != null);
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TopNewsScreen extends Screen {
  TopNewsScreen(Key key) : super(key: key);

  @override
  _ScreenState createState() => _TopNewsScreenState();
}

class _TopNewsScreenState extends _ScreenState {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocInjector.of(context).bloc;
    bloc.fetchData();

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: widget.key,
      slivers: <Widget>[
        TitleAppBar(title: 'Новости'),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2), () {
              bloc.fetchData();
            });
          },
        ),
        StreamBuilder(
          initialData: bloc.currentArticles,
          builder: (ctx, AsyncSnapshot<List<ArticleModel>> snapshot) {
            return SliverList(
              delegate: SliverChildListDelegate(snapshot.data
                  .map((articleModel) => NewsCard(articleModel: articleModel))
                  .toList()),
            );
          },
        )
      ],
    );
  }
}
