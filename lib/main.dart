import 'package:flutter/material.dart';
import 'package:weather_app/app_widget.dart';
import 'package:weather_app/injection_container.dart';

void main() {
  setupLocator();
  runApp(const AppWidget());
}
