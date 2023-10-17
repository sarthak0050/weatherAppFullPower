import 'dart:convert';
import 'package:weather_application_weekend_practice/views/weather_view/weather_model_view.dart';
import 'weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<WeatherModel> getRandomWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=delhi,india&APPID=e0626abb9bc6839d5105f609cac69906'));
    return WeatherModel.fromMap(jsonDecode(response.body));
  }

  Future<WeatherModel> getWeatherFromLocation(
      (double lat, double long) coord) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${coord.$1}&lon=${coord.$2}&appid=$openWeatherApiKey'));
    return WeatherModel.fromMap(jsonDecode(response.body));
  }

  Future<String> getWeatherInJsonForm() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=delhi,india&APPID=e0626abb9bc6839d5105f609cac69906'));
    return response.body;
  }
}
