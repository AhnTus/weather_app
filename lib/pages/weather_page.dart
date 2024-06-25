import 'package:demo/models/weather_model.dart';
import 'package:demo/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('f1c10ae4ceb1e88b90444376f97e92bd');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    //get the current  city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'rain':
        return 'assets/rain.json';

      case 'drizzle':
      case 'shower rain':
        return 'assets/thunder.json';

      case 'thunderstorm':
        return 'assets/thunderstorm.json';

      case 'clear':
        return 'assets/clear.json';

      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
 
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //city name
        Text(_weather?.cityName ?? "loading city..."),
        //animation
        // Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        Lottie.asset('assets/sunny.json'),

        //temperature
        Text('${_weather?.temperature.round()}℃')
      ])),
    );
  }
}
