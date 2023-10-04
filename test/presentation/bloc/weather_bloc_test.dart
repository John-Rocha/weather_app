import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(
      getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase,
    );
  });

  const testWeather = WeatherEntity(
    cityName: 'Macapá',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 30,
    pressure: 1012,
    humidity: 66,
  );

  const cityName = 'Macapá';

  test('initial state shoul be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherLoaded] when data is gotten successfully.',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(cityName))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        <WeatherState>[WeatherLoading(), const WeatherLoaded(testWeather)],
  );

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherError] when get data is unsuccessful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(cityName)).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => <WeatherState>[
      WeatherLoading(),
      const WeatherLoadError('Server failure'),
    ],
  );
}
