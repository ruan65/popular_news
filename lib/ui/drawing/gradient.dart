import 'package:clean_news_ai/domain/states/settings_state.dart';
import 'package:clean_news_ai/domain/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsGradient extends StatelessWidget {
  const NewsGradient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);
    return StreamBuilder(
      initialData: store.settingsState.color,
      stream: store
          .nextState<SettingsState>(state: store.settingsState)
          .map((state) => state.color)
          .distinct((prev, next) => prev == next),
      builder: (ctx, AsyncSnapshot<Color> snapshot) => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, snapshot.data]))),
    );
  }
}
