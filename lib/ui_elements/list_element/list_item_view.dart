import 'dart:core';

import 'package:cached_network_image/src/cached_network_image_provider.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/main_screen_element/main_screen_mutator.dart';
import 'package:clean_news_ai/screens/search_screen_element/search_screen_mutator.dart';
import 'package:clean_news_ai/screens/favorites_screen_element/favorites_screen_mutator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:clean_news_ai/provider/provider.dart';

class ListItemView extends StatefulWidget {
  final name;
  final url;
  final title;
  final publishedAt;
  final urlToImage;
  bool liked;

  ListItemView(this.name, this.url, this.title, this.publishedAt,
      this.urlToImage, this.liked) {
    //if(provider.savedArticles.containsKey(url)) liked = true;
  }

  createState() => ListItemViewState();
}

class ListItemViewState extends State<ListItemView>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 1.0, end: 0.5).animate(controller);
  }

  build(context) {
    if (widget.urlToImage != null) {
      final image = CachedNetworkImageProvider(widget.urlToImage);
      image
          .resolve(ImageConfiguration())
          .addListener((imageInfo, synchronousCall) {
        if (mounted) controller.forward();
      });
      return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      fullscreenDialog: true,
                      title: widget.name,
                      builder: (context) {
                        return WebViewRoute(widget.url);
                      })),
              child: Card(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: image,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(animation.value),
                              BlendMode.hardLight))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 16.0, right: 4.0),
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(widget.name,
                                    style: TextStyle(
                                        color: CupertinoColors.white))),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(CupertinoIcons.reply,
                                      color: Colors.white),
                                  onPressed: () async {
                                    Share.share(widget.url);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                      widget.liked
                                          ? CupertinoIcons.bookmark_solid
                                          : CupertinoIcons.bookmark,
                                      color: CupertinoColors.activeOrange),
                                  onPressed: () async {
                                    widget.liked
                                        ? await provider.deleteMyArticle(
                                            url: widget.url)
                                        : await provider
                                            .uploadMyArticle(holder: {
                                            "name": widget.name,
                                            "url": widget.url,
                                            "title": widget.title,
                                            "publishedAt": widget.publishedAt,
                                            "urlToImage": widget.urlToImage,
                                          });
                                    await favoritesMutator.getNews();
                                    setState((){
                                      widget.liked = !widget.liked;
                                                                            searchMutator.updateStars(
                                          url: widget.url);
                                      mainMutator.updateStars(url: widget.url);

                                      favoritesMutator.updateStars(
                                          url: widget.url);
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(widget.title,
                            style: TextStyle(
                                color: CupertinoColors.white, fontSize: 20)),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: Text(widget.publishedAt,
                            style: TextStyle(
                                color: CupertinoColors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      return Container();
    }
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class WebViewRoute extends StatelessWidget {
  final url;
  WebViewRoute(this.url);

  build(context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child:
          WebView(initialUrl: url, javascriptMode: JavascriptMode.unrestricted),
    );
  }
}
