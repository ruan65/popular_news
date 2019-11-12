import 'package:clean_news_ai/data/dto/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'list_element/news_card.dart';

class ArticleList extends StatelessWidget {
  final Stream<List<Article>> stream;
  final List<Article> initialData;
  const ArticleList({Key key, this.stream, this.initialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: initialData,
      stream: stream,
      builder: (ctx, AsyncSnapshot<List<Article>> snapshot) {
        return SliverList(
          delegate: SliverChildListDelegate(snapshot.data
              .map((article) => NewsCard(key: ValueKey(article.url), article: article))
              .toList()),
        );
      },
    );
  }
}
