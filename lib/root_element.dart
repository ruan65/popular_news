import 'dart:async';
import 'package:launch_review/launch_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'screens/favorites_screen_element/favorites_screen_view.dart';
import 'screens/main_screen_element/main_screen_view.dart';
import 'screens/search_screen_element/search_screen_view.dart';
import 'screens/settings_screen_element/settings_screen_view.dart';
import 'package:clean_news_ai/provider/provider.dart';

class RootElement extends StatelessWidget {

  
  build(context) {
    _showUpdateDialog(context);
    return CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightTheme
            ? CupertinoColors.white
            : CupertinoColors.darkBackgroundGray,
        tabBar: CupertinoTabBar(items: [
          const BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.time),
          ),
          const BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.search),
          ),
          const BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.bookmark),
          ),
          const BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.gear),
          ),
        ], activeColor: CupertinoColors.activeGreen,),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return mainScreenView;
              break;
            case 1: 
              return searchScreenView;
              break;
            case 2: 
              return favoritesScreenView;
              break;
            case 3: 
              return settingsScreenView;
              break;
          }
        });
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
