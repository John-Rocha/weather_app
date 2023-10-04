import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([
  WeatherRepository,
  WeatherRemoteDataSource
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'Macapá',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 30,
    pressure: 1012,
    humidity: 66,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'Macapá',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 30,
    pressure: 1012,
    humidity: 66,
  );

  const testCityName = 'Macapá';

  group('get current weather', () {
    test('should return weather entity when the response code is 200',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        'should return a server failure when the response code is 404 or other',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(result,
          equals(const Left(ServerFailure(message: 'An error has occurred'))));
    });

    test(
        'should return a connection failure when there is no internet connection',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      // assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure(message: 'No internet connection'))));
    });
  });
}
