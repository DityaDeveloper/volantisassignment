import '../../application/uri_constant.dart';

class ObservationWeatherModel {
  final int timestamp;
  final int humidity;

  final int tempCelcius;
  final num feeltempCelcius;

  final int tempfahrenheit;
  final int pressureMB;
  final num windspeedKPH;

  final int dewPointfahrenheit;
  final int dewPointfahrenheitmin;
  final int dewPointfahrenheitmax;
  final String weatherDesc;
  final String weatherPrimaryTitle;
  final int sunset;
  final int sunrise;
  final String icon;

  ObservationWeatherModel.fromJsonMap(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        humidity = json['humidity'],
        tempCelcius = json['tempC'] ?? 0,
        pressureMB = json['pressureMB'],
        feeltempCelcius = json['feelslikeC'] ?? 0,
        windspeedKPH = json['windSpeedKPH'],
        tempfahrenheit = json['tempF'],
        dewPointfahrenheit = json['dewpointF'],
        dewPointfahrenheitmin = json['minDewpointF'] ?? 0,
        dewPointfahrenheitmax = json['maxDewpointF'] ?? 0,
        weatherDesc = json['weather'],
        weatherPrimaryTitle = json['weatherPrimary'],
        sunrise = json['sunrise'],
        sunset = json['sunset'],
        icon = MasterUri.storageUrl.storage + json['icon'];
}
