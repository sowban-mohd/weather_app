part of 'weather_bloc.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final Weather weather;

  WeatherSuccess(this.weather);
}

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure(this.error);
}
