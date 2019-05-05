import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';
import 'package:clean_news_ai/ui_elements/list_element/list_item_view.dart';
import 'package:flutter/material.dart';

import 'abstract_state.dart';

abstract class AbstractScreenView extends StatelessWidget {
  final AbstractState state;
  final AbstractMutator mutator;
  AbstractScreenView({Key key, this.state, this.mutator}) : super(key: key) {
    mutator.getNews();
  }

  build(context) {
    return StreamBuilder(
        stream: state.broadcaster.stream,
        builder: (context, snapshot) {
          if (state.news.isEmpty && !snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          if (snapshot.hasData) {
            return ListView(
              children: [snapshot.data.values.map<Widget>((element) {
                return ListItemView(
                  key: ValueKey(element.url),
                  name: element.source['name'],
                  url: element.url,
                  title: element.title,
                  publishedAt: element.publishedAt,
                  urlToImage: element.urlToImage,
                  liked: element.liked,
                );
              }).toList()],
            );
          } else {
            return ListView(
              children: state.news.values.map<Widget>((element) {
                return ListItemView(
                  key: ValueKey(element.url),
                  name: element.source['name'],
                  url: element.url,
                  title: element.title,
                  publishedAt: element.publishedAt,
                  urlToImage: element.urlToImage,
                  liked: element.liked,
                );
              }).toList(),
            );
          }
        });
  }
}
