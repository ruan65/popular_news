import 'package:flutter/cupertino.dart';

import 'my_bloc.dart';

class BlocInjector extends InheritedWidget {
  BlocInjector({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  final Bloc bloc;

  static BlocInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(BlocInjector);

  @override
  bool updateShouldNotify(BlocInjector oldWidget) => bloc != oldWidget.bloc;
}
