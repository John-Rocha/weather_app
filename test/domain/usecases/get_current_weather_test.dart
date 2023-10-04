import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'Macapa',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '01n',
    temperature: 302.14,
    pressure: 1009,
    humidity: 74,
  );

  const testCityName = 'Macapa';

  test('should get current weather detail from the repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    // assert
    expect(result, const Right(testWeatherDetail));
  });

  test('should return current repository weather failure', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Left(ServerFailure(message: 'error')));

    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    // assert
    expect(result, const Left(ServerFailure(message: 'error')));
  });
}
