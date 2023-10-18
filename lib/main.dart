import 'package:flutter/material.dart';
import 'package:weather_application_weekend_practice/app/services/storage_service.dart';
import 'package:weather_application_weekend_practice/features/weather/weather_repo.dart';
import 'package:weather_application_weekend_practice/views/weather_view/weather_view.dart';
import 'package:weather_application_weekend_practice/views/weather_view/weather_model_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final WeatherRepository _repository;
  late final StorageService _storageService;
  @override
  void initState() {
    super.initState();
    _storageService = StorageService();
    _repository = WeatherRepository(_storageService);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: Provider<WeatherViewModel>(
        create: (_) => WeatherViewModel(_repository),
        builder: (_, __) => const WeatherScreen(),
      ),
    );
  }
}
