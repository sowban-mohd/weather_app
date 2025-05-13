import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Weather App'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: TextField(
            onSubmitted: (text) {
              BlocProvider.of<WeatherBloc>(context)
                  .add(WeatherFetched(cityName: text.trim()));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherScreen()));
            },
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: "Enter city name",
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              constraints: BoxConstraints(maxWidth: 400),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            controller: _cityNameController,
          ),
        ),
      ),
    );
  }
}
