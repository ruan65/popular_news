import 'package:clean_news_ai/main.dart';
import 'package:clean_news_ai/screens/main_screen_element/main_screen_mutator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/main_screen_element/main_screen_view.dart';

class SettingsScreenView extends StatefulWidget {
  createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreenView> {
  var settingsItems = [
    SettingsChip("business", false),
    SettingsChip("science", false),
    SettingsChip("general", false),
    SettingsChip("sport", false),
    SettingsChip("technology", false),
    SettingsChip("health", false),
    SettingsChip("entertainment", false)
  ];

  initState() {
    super.initState();
    getSelectedThemes();
  }

  build(context) {
    return CupertinoTabView(builder: (context) {
      return CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: const Text("Settings"),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 18.0, top: 18.0, bottom: 8.0),
          sliver: SliverToBoxAdapter(
            child: Text("Tags",
                style: TextStyle(
                    fontSize: 20,
                    color: lightTheme ? Colors.black : Colors.white)),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 18.0),
          sliver: SliverToBoxAdapter(
            child: Wrap(
                spacing: 8.0,
                children: settingsItems.map((item) {
                  return ActionChip(
                    padding: EdgeInsets.all(8.0),
                    //shape: ShapeBorder.lerp(a, b, t),
                    shadowColor: lightTheme
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.activeOrange,
                    onPressed: () async {
                      item.isSelected
                          ? await changeThemes(isRemove: true, theme: item.name)
                          : await changeThemes(
                              isRemove: false, theme: item.name);
                      setState(() {
                        item.isSelected = !item.isSelected;
                      });
                      mainMutator.getNews();
                      mainScreenView.scrollToTop();
                    },
                    backgroundColor: item.isSelected
                        ? CupertinoColors.activeOrange
                        : lightTheme
                            ? CupertinoColors.extraLightBackgroundGray
                            : CupertinoColors.darkBackgroundGray
                                .withOpacity(0.95),
                    label: Text(item.name),
                    labelStyle: TextStyle(
                        fontSize: 16,
                        color: lightTheme
                            ? CupertinoColors.darkBackgroundGray
                            : CupertinoColors.white),
                  );
                }).toList()),
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(
              color: lightTheme
                  ? CupertinoColors.lightBackgroundGray
                  : CupertinoColors.inactiveGray.withOpacity(0.5)),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          sliver: SliverToBoxAdapter(
              child: Row(
            children: [
              Expanded(
                child: Text("Dark Mode",
                    style: TextStyle(
                        fontSize: 20,
                        color: lightTheme ? Colors.black : Colors.white)),
              ),
              CupertinoSwitch(
                  activeColor: CupertinoColors.activeOrange,
                  value: !lightTheme,
                  onChanged: (value) async {
                    (await provider.prefs).setBool("t", !lightTheme);
                    setState(() {});
                    newsAppState.setState(() {
                      lightTheme = !lightTheme;
                    });
                  }),
            ],
          )),
        ),
      ]);
    });
  }

  getSelectedThemes() async {
    final List<String> themes = (await provider.prefs).getStringList("themes");
    if (themes == null) (await provider.prefs).setStringList("themes", []);
    settingsItems.forEach((item) {
      themes.contains(item.name)
          ? setState(() {
              item.isSelected = true;
            })
          : setState(() {
              item.isSelected = false;
            });
    });
  }

  changeThemes({bool isRemove, String theme}) async {
    final List themes = (await provider.prefs).getStringList("themes");
    if (themes == null) (await provider.prefs).setStringList("themes", []);
    isRemove ? themes.remove(theme) : themes.add(theme);
    themes.sort();
    (await provider.prefs).setStringList("themes", themes);
  }
}

class SettingsChip {
  bool isSelected;
  String name;
  SettingsChip(this.name, this.isSelected);
}

final settingsScreenView = SettingsScreenView();
