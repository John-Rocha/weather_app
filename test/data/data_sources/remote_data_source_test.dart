import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/contants/constants.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

@GenerateMocks([
  WeatherRepository
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(mockHttpClient);
  });
  const cityName = 'Macapá';
  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse(Constants.currentWeatherByName(cityName)),
      )).thenAnswer(
        (_) async => http.Response(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
          200,
        ),
      );
      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(cityName);
      // assert
      expect(result, isA<WeatherModel>());
    });

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse(Constants.currentWeatherByName(cityName)),
        )).thenAnswer(
          (_) async => http.Response(
            'Not Found',
            404,
          ),
        );
        // act
        final result = weatherRemoteDataSourceImpl.getCurrentWeather(cityName);
        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
