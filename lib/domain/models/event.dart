import 'package:flutter/foundation.dart';

enum EventType {
  refreshTopNewsState,
  refreshFavoriteNewsState,
  addToFavorite,
  removeFavorite,
  changeTheme,
  changeColor
}

class Event {
  final EventType type;
  final Object bundle;
  Event({@required this.type, this.bundle = const Object()});
}
