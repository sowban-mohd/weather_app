import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/models/weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<WeatherFetched>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather =
            await weatherRepository.getCurrentWeather(event.cityName);
        emit(WeatherSuccess(weather));
      } catch (e) {
        emit(WeatherFailure('An unexpected error occurred'));
      }
    });
  }
}
