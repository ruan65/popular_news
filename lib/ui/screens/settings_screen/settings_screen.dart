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
        TitleAppBar(title: 'Настройки'),
        SliverPadding(
          padding: EdgeInsets.only(top: 8),
        ),
        SliverFillRemaining(
          child: Column(children: [
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
                          //    presenter.changeColor(color);
                        },
                      ))
                  .toList(),
            ),
            Wrap(
              children: themes
                  .map((theme) => ActionChip(
                        label: Text(theme),
                        onPressed: () {
                          presenter.selectedThemes.add(theme);
                          presenter.change();
                        },
                      ))
                  .toList(),
            ),
            RaisedButton(
              child: Text('clear'),
              onPressed: () {
                presenter.selectedThemes.clear();
              },
            )
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

const themes = {
  'business',
  'entertainment',
  'health',
  'science',
  'sports',
  'technology'
};
