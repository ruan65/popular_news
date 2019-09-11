import 'package:clean_news_ai/ui/blocs/bloc.dart';
import 'package:flutter/cupertino.dart';

class BlocProvider extends InheritedWidget {
  BlocProvider({
    Key key,
    @required Widget child,
    @required this.bloc,
  });

  final Bloc bloc;

  static BlocProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(BlocProvider);

  @override
  bool updateShouldNotify(BlocProvider oldWidget) => oldWidget.bloc != bloc;
}
