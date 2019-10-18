import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'base_state.dart';

class SettingsState extends BaseState with EquatableMixin {
  String theme = '';
  Color color = Colors.blue;

  @override
  List<Object> get props => [theme, color];
}
