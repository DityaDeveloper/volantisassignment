import 'package:flutter/material.dart';

import 'package:volantisassignmenttoaditya/presentation/screen/forecast/forecast.dart';
import 'package:volantisassignmenttoaditya/presentation/screen/observation/observation.dart';
import 'package:volantisassignmenttoaditya/presentation/screen/weather/weather.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: const [
          ObservationScreen(),
          WeatherScreen(),
          ForecastScreen(),
        ]),
      ),
    );
  }
}
