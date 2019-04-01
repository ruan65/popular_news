import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';
import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:clean_news_ai/ui_elements/list_element/list_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_news_ai/ui_elements/search_bar_element/search_widget.dart';
import 'abstract_state.dart';

abstract class AbstractScreenView extends StatelessWidget {
  final AbstractMutator mutator;
  final AbstractState state;
  final String title;
  final bool isSearchScreen;
  final ScrollController scrollController = ScrollController();

  AbstractScreenView({Key key, this.mutator, this.state, this.title, this.isSearchScreen}) : super(key: key){
    mutator.getNews();
  }
  build(context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        CupertinoSliverNavigationBar(
          heroTag: ValueKey(title),
          largeTitle: isSearchScreen ? searchWidget : Text(title),
          middle: isSearchScreen ? const Text("Search") : null,
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await mutator.getNews();
          },
        ),
        StreamBuilder(
            stream: state.news,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final news = snapshot.data.values.map((element) {
                  return ListItemView(
                    key: ValueKey(element.url),
                    name: element.source["name"],
                    url: element.url,
                    title: element.title,
                    publishedAt: element.publishedAt,
                    urlToImage: element.urlToImage,
                    liked: element.liked,
                  );
                }).toList();
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return news[index];
                  }, childCount: snapshot.data.length),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: CupertinoActivityIndicator(
                      radius: 14.0,
                    ),
                  ),
                );
              }
            }),
        emptyBox
      ],
    );
  }

  scrollToTop() {
    scrollController.jumpTo(0.0);
  }
}
