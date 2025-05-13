import 'package:weather_app/models/hourly_forecast.dart';

class Weather {
  final double currentTemp;
  final String currentSky;
  final int currentHumidity;
  final int currentPressure;
  final double currentWindSpeed;
  final List<HourlyForecast> hourlyForecast;

  Weather(
      {required this.currentTemp,
      required this.currentSky,
      required this.currentHumidity,
      required this.currentPressure,
      required this.currentWindSpeed,
      required this.hourlyForecast
      });

  // fromMap method to create an instance of Weather from a Map
  factory Weather.fromMap(Map<String, dynamic> map) {
    final weatherList = map['list'] as List;
    final currentWeatherData = weatherList[0];
    final hourlyForecastList = weatherList.sublist(1);

    return Weather(
      currentTemp: currentWeatherData['main']['temp'] as double,
      currentSky: currentWeatherData['weather'][0]['main'] as String,
      currentHumidity: currentWeatherData['main']['humidity'] as int,
      currentPressure: currentWeatherData['main']['pressure'] as int,
      currentWindSpeed: currentWeatherData['wind']['speed'] as double,
      hourlyForecast: hourlyForecastList.map((forecast) {
        return HourlyForecast(
          hourlyTemp: forecast['main']['temp'].toString(),
          hourlySky: forecast['weather'][0]['main'] as String,
          time: DateTime.parse(forecast['dt_txt'] as String),
        );
      }).toList(),
    );
  }

  // toMap method to convert the Weather instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentHumidity': currentHumidity,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
    };
  }
}
