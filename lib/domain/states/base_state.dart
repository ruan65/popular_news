import 'dart:async';

abstract class BaseState {
  final StreamController<BaseState> selfBroadcaster = StreamController<BaseState>.broadcast();
  void update() => selfBroadcaster.add(this);
  Stream<BaseState> get selfStream => selfBroadcaster.stream.distinct((prev, next) => prev != next);
}
