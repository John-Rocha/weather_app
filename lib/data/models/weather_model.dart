import 'package:weather_app/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.main,
    required super.description,
    required super.iconCode,
    required super.temperature,
    required super.pressure,
    required super.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> jsonMap) {
    return WeatherModel(
      cityName: jsonMap['name'],
      main: jsonMap['weather'][0]['main'],
      description: jsonMap['weather'][0]['description'],
      iconCode: jsonMap['weather'][0]['icon'],
      temperature: jsonMap['main']['temp'],
      pressure: jsonMap['main']['pressure'],
      humidity: jsonMap['main']['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': iconCode,
        }
      ],
      'main': {
        'temp': temperature,
        'pressure': pressure,
        'humidity': humidity,
      }
    };
  }
}
