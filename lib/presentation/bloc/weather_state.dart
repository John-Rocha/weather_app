part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherEmpty extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity weatherEntity;

  const WeatherLoaded(this.weatherEntity);

  @override
  List<Object> get props => [weatherEntity];
}

final class WeatherLoadError extends WeatherState {
  final String message;

  const WeatherLoadError(this.message);

  @override
  List<Object> get props => [message];
}
