import 'package:clean_news_ai/domain/event_enum.dart';
import 'package:clean_news_ai/ui/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:osam/osam.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_manager/executor.dart';

import 'data/database/database_repository.dart';
import 'data/dto/article.g.dart';
import 'data/dto/source.g.dart';
import 'domain/middleware/favorite_middleware.dart';
import 'domain/middleware/news_middleware.dart';
import 'domain/states/app_state.dart';

const isolatePoolSize = 2;

void main() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(SourceAdapter(), 221);
  Hive.registerAdapter(ArticleAdapter(), 222);
  await DatabaseRepository.hive().init();
  await Executor(isolatePoolSize: isolatePoolSize).warmUp();
  runApp(MaterialApp(
      home: StoreProvider(
    store: Store(AppState(), middleWares: [NewsMiddleware(), FavoriteMiddleware()])
      ..dispatchEvent(event: Event.sideEffect(type: EventType.fetchNews, bundle: 'science')),
    child: BaseScreen(),
  )));
}
