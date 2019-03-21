import 'dart:async';

abstract class AbstractState {
  Map cashedData = {};
  final broadcaster = StreamController.broadcast();
  get news => broadcaster.stream;

}
