import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

import 'dart:convert';
import 'package:weather_application_weekend_practice/app/services/storage_service.dart';
import 'package:weather_application_weekend_practice/features/weather/weather_model.dart';
import 'package:weather_application_weekend_practice/features/weather/weather_repo.dart';

const String openWeatherApiKey = 'e0626abb9bc6839d5105f609cac69906';

class WeatherViewModel {
  final WeatherRepository _repository;
  final StorageService _storageService;

  WeatherViewModel(this._repository, this._storageService);

  final ValueNotifier<WeatherModel?> _weatherNotifier = ValueNotifier(null);

  ValueListenable<WeatherModel?> get weatherNotifier => _weatherNotifier;
  Position? position;

  Future<void> initialise() async {
    final String? sp = await _storageService.get('jsonString');
    if (sp != null) {
      _weatherNotifier.value = WeatherModel.fromMap(jsonDecode(sp));
    } else {
      await _getCurrentPosition();
      await getWeather();
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const Text('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        const Text('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      const Text(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<Position?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getWeather() async {
    late final WeatherModel response;
    if (position != null) {
      response = await _repository
          .getWeatherFromLocation((position!.latitude, position!.longitude));
    } else {
      response = await _repository.getRandomWeather();
    }

    _weatherNotifier.value = response;

    // await _storageService.save('jsonString', response.toJson());
    String json = await _repository.getWeatherInJsonForm();
    await _storageService.save('jsonString', json);
  }
}
