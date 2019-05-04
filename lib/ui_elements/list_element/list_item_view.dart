import 'dart:core';
import 'package:clean_news_ai/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ListItemView extends StatefulWidget {
  final name;
  final url;
  final title;
  final publishedAt;
  final urlToImage;
  final liked;

  ListItemView(
      {Key key,
      this.name,
      this.url,
      this.title,
      this.publishedAt,
      this.urlToImage,
      this.liked})
      : super(key: key);

  createState() => ListItemViewState();
}

class ListItemViewState extends State<ListItemView>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  bool liked;

  initState() {
    super.initState();
    liked = widget.liked;
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 1.0, end: 0.5).animate(controller);
  }

  build(context) {
    final image = Image.network(widget.urlToImage ?? "nothing").image;
    image
        .resolve(ImageConfiguration())
        .addListener((imageInfo, synchronousCall) {
      if (mounted) controller.forward();
    });
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return Scaffold(
                  appBar: CupertinoNavigationBar(
                    previousPageTitle: "back",
                    transitionBetweenRoutes: false,
                    middle: Text(widget.name),
                  ),
                  body: WebView(
                    initialUrl: widget.url,
                  ),
                );
              }));
            },
            child: Card(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
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
                                  style:
                                      TextStyle(color: CupertinoColors.white))),
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
                                    liked
                                        ? CupertinoIcons.bookmark_solid
                                        : CupertinoIcons.bookmark,
                                    color: CupertinoColors.activeOrange),
                                onPressed: () async {
                                  liked
                                      ? provider.deleteMyArticle(
                                          url: widget.url)
                                      : provider.uploadMyArticle(holder: {
                                          "name": widget.name,
                                          "url": widget.url,
                                          "title": widget.title,
                                          "publishedAt": widget.publishedAt,
                                          "urlToImage": widget.urlToImage,
                                        });
                                  setState(() {
                                    liked = !liked;
                                  });
                                  // await favoritesMutator.getNews();
                                  // searchMutator.updateStars(url: widget.url);
                                  // mainMutator.updateStars(url: widget.url);
                                  // favoritesMutator.updateStars(url: widget.url);
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
                          style: TextStyle(color: CupertinoColors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
