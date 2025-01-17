import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/app_configs.dart';

void main() async {
  await appConfigs();
  runApp(const MyApp());
}
