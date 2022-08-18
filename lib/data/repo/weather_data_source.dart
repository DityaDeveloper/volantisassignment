import 'package:flutter/foundation.dart';

import '../../application/uri_constant.dart';
import '../network/base_network.dart';

class WeatherDataSource {
  Future<dynamic> loadDailyForecastWeatherList(double lat, double long) async {
    String pathUrl = '${MasterUri.pathWeather.dailyforecast}/$lat,$long';
    debugPrint("path daily forecast running on : $pathUrl");
    return BaseNetwork().getList(pathUrl);
  }

  Future<dynamic> loadDailyForecastWeatherListWithCountry(
      String country, String city) async {
    String pathUrl = '${MasterUri.pathWeather.dailyforecast}/$country,$city';
    debugPrint("path daily forecast running on : $pathUrl");
    return BaseNetwork().getList(pathUrl);
  }

  Future<dynamic> loadDailyWeatherList(
      String time, double lat, double long) async {
    String pathUrl =
        '${MasterUri.pathWeather.daily}/$lat,$long?from=$time:00&to=+22hours';
    debugPrint("path daily weather running on : $pathUrl");
    return BaseNetwork().getList(pathUrl);
  }

  Future<dynamic> loadDailyWeatherListWithCountry(
      String time, String city, String country) async {
    String pathUrl =
        '${MasterUri.pathWeather.daily}/$country,$city?from=$time:00&to=+22hours';
    debugPrint("path daily weather running on : $pathUrl");
    return BaseNetwork().getList(pathUrl);
  }

  Future<dynamic> loadDailyObservationWeather(double lat, double long) async {
    String pathUrl = '${MasterUri.pathWeather.observation}/$lat,$long';
    debugPrint("path observation running on : $pathUrl");
    return BaseNetwork().getList(pathUrl);
  }

  Future<dynamic> loadDailyObservationWeatherWithCountry(
      String city, String country) async {
    String pathUrl = '${MasterUri.pathWeather.observation}/$country,$city';
    debugPrint("path observation running on : $pathUrl");
    return BaseNetwork().getList(pathUrl);
  }
}
