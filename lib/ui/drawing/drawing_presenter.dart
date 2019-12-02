//import 'dart:async';
//import 'dart:ui';
//
//import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
//import 'package:osam/domain/store/store.dart';
//import 'package:osam/presentation/presenter.dart';
//
//class DrawingPresenter extends Presenter<Store<AppState>> {
//  StreamSubscription<Color> colorSub;
//  Stream<Color> get stream => _broadcaster.stream;
//  StreamController<Color> _broadcaster;
//  Color get initialData => store.state.settingsState.color;
//
//  @override
//  void init() {
//    _broadcaster = StreamController<Color>.broadcast();
////    colorSub =
////        store.state.settingsState.propertyStream<Color>((state) => state.color).listen((color) {
////      _broadcaster.sink.add(color);
//    });
//  }
//
//  @override
//  void dispose() {
//    colorSub.cancel();
//    _broadcaster.close();
//  }
//}
