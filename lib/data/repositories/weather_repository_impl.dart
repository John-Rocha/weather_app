import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }
}
