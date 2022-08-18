import '../../application/uri_constant.dart';

double reciprocal(double d) => 1 / d;

class WeatherModel {
  final int timestamp;
  final int humidity;

  final double tempCelcius;

  final double tempfahrenheit;
  final int uvi;

  final String weatherDesc;
  final String weatherPrimaryTitle;
  final int sunset;
  final int sunrise;
  final String icon;

  WeatherModel.fromJsonMap(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        humidity = json['humidity'],
        tempCelcius = json['tempC'].toDouble(),
        uvi = json['uvi'] ?? 0,
        tempfahrenheit = json['tempF'].toDouble(),
        weatherDesc = json['weather'],
        weatherPrimaryTitle = json['weatherPrimary'],
        sunrise = json['sunrise'] ?? 0,
        sunset = json['sunset'] ?? 0,
        icon = MasterUri.storageUrl.storage + json['icon'];
}
