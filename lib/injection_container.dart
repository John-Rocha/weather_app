import 'package:get_it/get_it.dart';
import 'package:weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  //bloc
  locator.registerFactory(
    () => WeatherBloc(getCurrentWeatherUseCase: locator()),
  );

  //usecases
  locator.registerLazySingleton(
    () => GetCurrentWeatherUseCase(weatherRepository: locator()),
  );

  //repositories
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: locator(),
    ),
  );

  //datasources
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(locator()),
  );

  //external
  locator.registerLazySingleton(() => http.Client());
}
