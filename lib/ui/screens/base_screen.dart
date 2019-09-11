import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/widgets/navigation_app_bar.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          const NewsGradient(),
          TabBarView(controller: _controller, children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                TitleAppBar(
                  controller: _controller,
                  title: 'Новости',
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      '123',
                      style: TextStyle(fontSize: 170),
                    ),
                    Text(
                      '123',
                      style: TextStyle(fontSize: 170),
                    ),
                    Text(
                      '123',
                      style: TextStyle(fontSize: 170),
                    ),
                    Text(
                      '123',
                      style: TextStyle(fontSize: 170),
                    ),
                    Text(
                      '123',
                      style: TextStyle(fontSize: 170),
                    )
                  ]),
                )
              ],
            ),
            CustomScrollView(
              slivers: <Widget>[
                TitleAppBar(
                  controller: _controller,
                  title: 'Поиск',
                )
              ],
            ),
            CustomScrollView(
              slivers: <Widget>[
                TitleAppBar(
                  controller: _controller,
                  title: 'Сохраненные',
                )
              ],
            ),
            CustomScrollView(
              slivers: <Widget>[
                TitleAppBar(
                  controller: _controller,
                  title: 'Настройки',
                )
              ],
            ),
          ]),
          NavigationAppBar(
            controller: _controller,
          )
        ],
      ),
    );
  }
}
