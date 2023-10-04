import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc({required GetCurrentWeatherUseCase getCurrentWeatherUseCase})
      : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        super(WeatherEmpty()) {
    on<OnCityChanged>(
      onCityChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<FutureOr<void>> onCityChanged(
    OnCityChanged event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    final result = await _getCurrentWeatherUseCase.execute(event.cityName);
    result.fold(
      (failure) => emit(WeatherLoadError(failure.message)),
      (weatherEntity) => emit(WeatherLoaded(weatherEntity)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
