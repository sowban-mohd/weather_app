import 'dart:convert';
import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/weather.dart';

class WeatherRepository {
  final WeatherDataProvider dataProvider;
  WeatherRepository(this.dataProvider);

  Future<Weather> getCurrentWeather() async {
    try {
      String cityName = 'New Delhi';
      final res = await dataProvider.getCurrentWeather(cityName);

      final Map<String, dynamic> data = jsonDecode(res);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return Weather.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
