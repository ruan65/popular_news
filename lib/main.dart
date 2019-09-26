import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worker_manager/worker_manager.dart';

import 'ui/screens/base_screen.dart';

void main() async {
  await Executor(threadPoolSize: 2).warmUp();
  runApp(MaterialApp(home: BaseScreen()));
}
