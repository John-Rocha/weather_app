part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weatherEntity;

  const WeatherLoaded(this.weatherEntity);

  @override
  List<Object> get props => [weatherEntity];
}

class WeatherLoadError extends WeatherState {
  final String message;

  const WeatherLoadError(this.message);

  @override
  List<Object> get props => [message];
}
