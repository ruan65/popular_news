import 'dart:async';
import 'package:clean_news_ai/screens/main_screen/main_screen_view.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:launch_review/launch_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/favorites_screen_element/favorites_screen_view.dart';
import 'screens/search_screen_element/search_screen_view.dart';
import 'screens/settings_screen_element/settings_screen_view.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'res/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RootBody extends StatefulWidget {
  createState() => RootBodyState();
}

class RootBodyState extends State<RootBody> with TickerProviderStateMixin {
  TabController _tabController;
  int currentIndex = 0;
  final titles = [en['daily'], en['search'], en['favorites'], en['settings']];

  initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      vsync: this,
      length: 4,
    )..addListener(() {
        setState(() {
          _tabController.animateTo(_tabController.index,
              duration: Duration(milliseconds: 100));
          currentIndex = _tabController.index;
        });
      });
  }

  build(context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NestedScrollView(
        headerSliverBuilder: (context, boxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
                border: null,
                backgroundColor: Colors.transparent,
                transitionBetweenRoutes: true,
                largeTitle: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                      AnimationController(
                          duration: Duration(milliseconds: 200), vsync: this)
                        ..forward()),
                  child: Text(
                    titles[currentIndex].toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
          ];
        },
        body: Stack(
          children: <Widget>[
            TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                mainScreenView,
                searchScreenView,
                favoritesScreenView,
                settingsScreenView
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoTabBar(
                backgroundColor: Colors.transparent,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.white,
                currentIndex: currentIndex,
                onTap: (index) {
                  _tabController.index = index;
                },
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Icon(CupertinoIcons.bell),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Icon(CupertinoIcons.search),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Icon(CupertinoIcons.bookmark),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Icon(CupertinoIcons.gear),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _showUpdateDialog(context) async {
    final result = await provider.isReadyToUpdate();
    if (result) {
      Future.delayed(Duration(seconds: 1), () {
        showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Application is ready to update"),
              actions: [
                FlatButton(
                    onPressed: () {
                      LaunchReview.launch();
                    },
                    child: Text("Ok"))
              ],
            );
          },
        );
      });
    }
  }
}

class MainScreenView {}
