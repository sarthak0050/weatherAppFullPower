import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'weather_model_view.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final WeatherViewModel wvm;

  @override
  void initState() {
    super.initState();
    wvm = context.read<WeatherViewModel>();
    wvm.initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: wvm.weatherNotifier,
          builder: (_, weather, __) {
            if (weather == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.blueGrey],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud,
                    size: 150,
                    color: Colors.white,
                  ),
                  Text(
                    weather.temperature.toString(),
                    style: const TextStyle(fontSize: 80, color: Colors.white),
                  ),
                  Text(
                    weather.condition,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(weather.description),
                    ],
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          wvm.getWeather();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
