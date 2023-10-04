import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/contants/constants.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl(this.client);

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final http.Response(:body, :statusCode) = await client.get(
      Uri.parse(
        Constants.currentWeatherByName(cityName),
      ),
    );
    if (statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(body));
    } else {
      throw Exception();
    }
  }
}
