import 'dart:ui';

import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

class NavigationAppBar extends StatelessWidget {
  const NavigationAppBar({Key key, this.controller}) : super(key: key);
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<NavigationPresenter>(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: StreamBuilder(
            stream: presenter.stream,
            initialData: presenter.initialData,
            builder: (context, snapshot) {
              controller.animateTo(snapshot.data);
              return TabBar(
                indicator: BoxDecoration(
                  color: Colors.transparent,
                ),
                controller: controller,
                tabs: <Widget>[
                  GestureDetector(
                      onTap: () {
                        presenter.routeTo(0);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.time),
                      )), // Icon(CupertinoIcons.search),
                  GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.book),
                      ),
                      onTap: () {
                        presenter.routeTo(1);
                      }), //  Icon(CupertinoIcons.gear),
                ],
              );
            }),
      ),
    );
  }
}
