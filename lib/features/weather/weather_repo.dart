import 'dart:convert';
import 'package:weather_application_weekend_practice/app/services/storage_service.dart';
import 'package:weather_application_weekend_practice/views/weather_view/weather_model_view.dart';
import 'weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final StorageService _service;

  const WeatherRepository(this._service);

  Future<WeatherModel> getRandomWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=delhi,india&APPID=e0626abb9bc6839d5105f609cac69906'));
    return WeatherModel.fromMap(jsonDecode(response.body));
  }

  Future<WeatherModel> getWeatherFromLocation(
      (double lat, double long) coord) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${coord.$1}&lon=${coord.$2}&appid=$openWeatherApiKey'));
    await _service.save("json", response.body);
    return WeatherModel.fromMap(jsonDecode(response.body));
  }

  Future<WeatherModel?> getWeatherFromStorage() async {
    final data = await _service.get("json");
    if (data == null) return null;
    return WeatherModel.fromStorageMap(jsonDecode(data));
  }
}
