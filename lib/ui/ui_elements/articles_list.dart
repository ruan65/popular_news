import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'list_element/news_card.dart';

class ArticleList extends StatelessWidget {
  final Stream<List<ArticleModel>> stream;
  final List<ArticleModel> initialData;
  const ArticleList({Key key, this.stream, this.initialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: initialData,
      stream: stream,
      builder: (ctx, AsyncSnapshot<List<ArticleModel>> snapshot) {
        return SliverList(
          delegate: SliverChildListDelegate(snapshot.data
              .map((articleModel) =>
                  NewsCard(key: ValueKey(articleModel.article.url), articleModel: articleModel))
              .toList()),
        );
      },
    );
  }
}
