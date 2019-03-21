import 'package:clean_news_ai/main.dart';
import 'package:clean_news_ai/screens/main_screen_element/main_screen_mutator.dart';
import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_news_ai/screens/main_screen_element/main_screen_view.dart';
import 'settings_screen_mutator.dart';
import 'settings_screen_state.dart';

class SettingsScreenView extends StatelessWidget {
  SettingsScreenView() {
    mutator.getSelectedThemes();
  }

  final prefs = SharedPreferences.getInstance();

  final settingsItems = [
    "Business",
    "Science",
    "Entertainment",
    "Sport",
    "Health",
    "Technology",
    "General",
  ];

  build(context) {
    return CupertinoTabView(builder: (context) {
      return CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: const Text("Settings"),
        ),
        StreamBuilder(
            stream: state.selectedThemes,
            builder: (context, snapshot) {
              return SliverPadding(
                padding: EdgeInsets.all(18.0),
                sliver: SliverToBoxAdapter(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: snapshot.hasData
                        ? settingsItems.map((theme) {
                            return ActionChip(
                              padding: EdgeInsets.all(8.0),
                              shadowColor: CupertinoColors.activeGreen,
                              onPressed: () async {
                                final themes =
                                    await mutator.getSelectedThemes();
                                themes.contains(theme.toLowerCase())
                                    ? await mutator
                                        .deleteTheme(theme.toLowerCase())
                                    : await mutator
                                        .addTheme(theme.toLowerCase());
                                mainMutator.getNews();
                                mainScreenView.scrollToTop();
                              },
                              backgroundColor:
                                  snapshot.data.contains(theme.toLowerCase())
                                      ? CupertinoColors.activeGreen
                                      : CupertinoColors.inactiveGray,
                              label: Text(theme),
                              labelStyle: TextStyle(fontSize: 20),
                            );
                          }).toList()
                        : settingsItems.map((theme) {
                            return Chip(
                              padding: EdgeInsets.all(8.0),
                              backgroundColor: CupertinoColors.inactiveGray,
                              label: Text(theme),
                              labelStyle: TextStyle(fontSize: 20),
                            );
                          }).toList(),
                  ),
                ),
              );
            }),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: ActionChip(
              padding: EdgeInsets.all(8.0),
              backgroundColor: CupertinoColors.activeGreen,
              shadowColor: CupertinoColors.activeGreen,
              label: Text("Change theme"),
              labelStyle: TextStyle(fontSize: 20),
              onPressed: () async {
                (await prefs).setBool("t", !lightTheme);
                newsAppState.setState(() {
                  lightTheme = !lightTheme;
                });
              },
            ),
          ),
        ),
        emptyBox
      ]);
    });
  }
}

final settingsScreenView = SettingsScreenView();
