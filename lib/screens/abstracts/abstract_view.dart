
import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:clean_news_ai/ui_elements/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_news_ai/ui_elements/search_bar_element/search_widget.dart';
import 'abstract_state.dart';

abstract class AbstractScreenView extends StatelessWidget {
  final mutator;
  final AbstractState state;
  final title;
  final isSearchScreen;
  final ScrollController scrollController = ScrollController();

  AbstractScreenView(
      this.mutator, this.title, this.state, this.isSearchScreen) {
    mutator.getNews();
  }

  build(context) {
    return CupertinoTabView(
      builder: (context) {
        return CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
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
                    return ListWidget(snapshot.data.values.toList());
                  } else {
                    return const SliverToBoxAdapter();
                  }
                }),
            emptyBox
          ],
        );
      },
    );
  }

  scrollToTop() {
    scrollController.jumpTo(0.0);
  }
}
