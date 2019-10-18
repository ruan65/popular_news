import 'package:clean_news_ai/ui/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_manager/executor.dart';

import 'data/database/database_repository.dart';
import 'data/dto/article.g.dart';
import 'data/dto/source.g.dart';

void main() async {
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(SourceAdapter(), 221);
  Hive.registerAdapter(ArticleAdapter(), 222);
  await DatabaseRepository.hive().init();
  await Executor(threadPoolSize: 2).warmUp();
  runApp(MaterialApp(home: BaseScreen()));
}
