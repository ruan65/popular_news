import 'dart:async';

abstract class AbstractState {
  Map cashedArticles = {};
  final broadcaster = StreamController.broadcast();
  get news => broadcaster.stream;

  close(){
    broadcaster.close();
  }
}
