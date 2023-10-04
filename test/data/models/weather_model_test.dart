import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';

import '../../helpers/json_reader.dart';

const testWeatherModel = WeatherModel(
  cityName: 'Macapá',
  description: 'clear sky',
  main: 'Clear',
  iconCode: '01n',
  temperature: 302.14,
  pressure: 1009,
  humidity: 74,
);

void main() {
  test('should be a subclass of weather entity', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    // act
    final result = testWeatherModel.toJson();

    // assert
    final expectedMap = {
      "name": "Macapá",
      "weather": [
        {"main": "Clear", "description": "clear sky", "icon": "01n"}
      ],
      "main": {"temp": 302.14, "pressure": 1009, "humidity": 74}
    };
    expect(result, equals(expectedMap));
  });
}
