import 'dart:async';

abstract class Bloc {
  StreamController broadcaster;

  Stream get stream => broadcaster.stream;

  void initBloc() {
    broadcaster = StreamController.broadcast();
  }

  void closeBloc() {
    broadcaster.close();
  }
}
