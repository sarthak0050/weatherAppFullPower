import 'dart:convert';

class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final String description;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.description,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      city: map['name'],
      temperature: map['main']['temp'],
      condition: map['weather'][0]['main'],
      description: map['weather'][0]['description'],
    );
  }

  String toJson() {
    final Map<String, dynamic> map = {
      "city": city,
      "temperature": temperature,
      "condition": condition,
      "description": description
    };
    return jsonEncode(map);
  }

  factory WeatherModel.fromStorageMap(Map<String, dynamic> map) {
    return WeatherModel(
        city: map['city'],
        temperature: map['temperature'],
        condition: map["condition"],
        description: map['description']);
  }
}
