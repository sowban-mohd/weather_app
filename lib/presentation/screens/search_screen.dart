import 'package:flutter/material.dart';
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
              if (text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please enter a city name",
                    ),
                  ),
                );
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherScreen(
                          cityName: _cityNameController.text.trim())));
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
