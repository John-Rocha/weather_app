import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository _weatherRepository;

  const GetCurrentWeather({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository;

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return _weatherRepository.getCurrentWeather(cityName);
  }
}
