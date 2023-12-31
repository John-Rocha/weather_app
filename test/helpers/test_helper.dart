import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';

@GenerateMocks([
  WeatherRepository,
  AuthRepository,
  WeatherRemoteDataSource,
  GetCurrentWeatherUseCase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
