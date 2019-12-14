import 'package:clean_news_ai/ui/screens/settings_screen/settings_presenter.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<SettingsPresenter>(context);
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        TitleAppBar(title: 'Settings'),
        SliverPadding(
          padding: EdgeInsets.only(top: 8),
        ),
        SliverFillRemaining(
          child: Column(children: [
            StreamBuilder(
              initialData: presenter.initialData,
              stream: presenter.themesStream,
              builder: (ctx, AsyncSnapshot<List<String>> snapshot) => Wrap(
                children: themes.map((theme) {
                  final isSelected = snapshot.data.contains(theme);
                  return ActionChip(
                    backgroundColor: isSelected ? Colors.blue : Colors.white,
                    elevation: isSelected ? 1 : 3,
                    label: Text(
                      theme,
                      style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
                    ),
                    onPressed: () {
                      isSelected ? presenter.removeTheme(theme) : presenter.addTheme(theme);
                    },
                  );
                }).toList(),
              ),
            ),
            Wrap(
              children: colors
                  .map((color) => ActionChip(
                        backgroundColor: color,
                        shadowColor: color,
                        label: Container(
                          width: 10,
                          color: color,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onPressed: () {
                          presenter.changeColor(color);
                        },
                      ))
                  .toList(),
            ),
          ]),
        )
      ],
    );
  }
}

const colors = [
  Colors.purple,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
];

const themes = {'business', 'entertainment', 'health', 'science', 'sports', 'technology'};
