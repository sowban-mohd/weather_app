import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child:
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherFailure) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
              );
            }
            if (state is! WeatherSuccess) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Column(
                          children: [
                            Text(
                              '${state.weather.currentTemp} K',
                              style: const TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Icon(
                              state.weather.currentSky == 'Clouds' ||
                                      state.weather.currentSky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.wb_sunny,
                              size: 64,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.weather.currentSky,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hourly Forecast",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.weather.hourlyForecast.length,
                      itemBuilder: (context, index) {
                        final forecast = state.weather.hourlyForecast[index];
                        return Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                forecast.hourlySky == 'Clouds' ||
                                        forecast.hourlySky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${forecast.hourlyTemp}K',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                DateFormat.j().format(forecast.time),
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoIcon(Icons.water_drop, "Humidity",
                          state.weather.currentHumidity.toString()),
                      _infoIcon(Icons.air, "Wind",
                          state.weather.currentWindSpeed.toString()),
                      _infoIcon(Icons.compress, "Pressure",
                          state.weather.currentPressure.toString())
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _infoIcon(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
