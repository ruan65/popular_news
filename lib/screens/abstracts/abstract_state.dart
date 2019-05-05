import 'package:clean_news_ai/models/Item_model.dart';
import 'dart:async';

abstract class AbstractState {
  final Map<String, Article> news = {};
  final StreamController<Map> broadcaster = StreamController.broadcast();
  closeBroadcaster(){
    broadcaster.close();
  }
}