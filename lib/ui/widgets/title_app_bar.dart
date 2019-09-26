import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  final String title;

  const TitleAppBar({this.title, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
        border: null,
        backgroundColor: Colors.transparent,
        transitionBetweenRoutes: true,
        largeTitle: Text(
          title,
          style: TextStyle(color: Colors.white),
        ));
  }
}

//class _TitleAppBarWithSearch extends TitleAppBar {
//  final String title;
//  const _TitleAppBarWithSearch({this.title}) : super(title: title);
//  @override
//  Widget build(BuildContext context) {
//    return SliverPersistentHeader(
//      pinned: true,
//      delegate: _SearchWidgetDelegate(title: title),
//    );
//  }
//}
//
//class _SearchWidgetDelegate extends SliverPersistentHeaderDelegate {
//  final String title;
//  const _SearchWidgetDelegate({this.title});
//
//  @override
//  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//    final appBarSize = 50 - shrinkOffset;
//    final proportion = 2 - (50 / appBarSize);
//    final opacityPercent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
//    return Container(
//      height: appBarSize,
//      width: double.infinity,
//      color: Colors.red,
//    );
//  }
//
//  @override
//  double get maxExtent => 50;
//
//  @override
//  double get minExtent => 0;
//
//  @override
//  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => this != oldDelegate;
//}
