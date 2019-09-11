import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worker_manager/worker_manager.dart';

import 'ui/screens/base_screen.dart';

void main(
    ) async {
  await Executor(
  ).initExecutor(
  );
  runApp(
      MaterialApp(
          home: const BaseScreen(
          )
          )
      );
}
