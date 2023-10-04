import 'package:flutter/material.dart';
import 'package:weather_app/core/provider/application_provider.dart';
import 'package:weather_app/presentation/pages/weather_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ApplicationProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        home: WeatherPage(),
      ),
    );
  }
}
