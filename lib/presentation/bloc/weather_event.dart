part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class OnCityEmpty extends WeatherEvent {
  final String cityName;
  const OnCityEmpty({this.cityName = ''});
}

class OnCityChanged extends WeatherEvent {
  final String cityName;

  const OnCityChanged(this.cityName);

  @override
  List<Object> get props => [cityName];
}
