import 'package:clean_news_ai/screens/search_screen_element/search_screen_mutator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchWidget extends StatelessWidget {
  final textController = TextEditingController();

  build(context) {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.inactiveGray,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: CupertinoTextField(
              controller: textController,
              placeholder: "Search",
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: "SanFrancisco",
              ),
              prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.search)),
              decoration: BoxDecoration(border: null),
              clearButtonMode: OverlayVisibilityMode.editing,
              onSubmitted: (value) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString("lastRequest", value);
                searchMutator.getNews();
              }),
        ));
  }
}

final searchWidget = SearchWidget();
