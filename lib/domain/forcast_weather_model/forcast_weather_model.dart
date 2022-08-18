import '../../application/uri_constant.dart';

class ForcastWeatherModel {
  final int timestamp;
  final int humidity;
  final int humiditymin;
  final int humiditymax;
  final int tempCelcius;
  final int tempCelciusmin;
  final int tempCelciusmax;
  final int tempfahrenheit;
  final int tempfahrenheitmax;
  final int tempfahrenheitmin;
  final int dewPointfahrenheit;
  final int dewPointfahrenheitmin;
  final int dewPointfahrenheitmax;
  final String weatherDesc;
  final String weatherPrimaryTitle;
  final int sunset;
  final int sunrise;
  final String icon;

  ForcastWeatherModel.fromJsonMap(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        humidity = json['humidity'],
        humiditymin = json['minHumidity'],
        humiditymax = json['maxHumidity'],
        tempCelcius = json['avgTempC'],
        tempCelciusmin = json['minTempC'],
        tempCelciusmax = json['maxTempC'],
        tempfahrenheit = json['avgTempF'],
        tempfahrenheitmin = json['minTempF'],
        tempfahrenheitmax = json['maxTempF'],
        dewPointfahrenheit = json['dewpointF'],
        dewPointfahrenheitmin = json['minDewpointF'],
        dewPointfahrenheitmax = json['maxDewpointF'],
        weatherDesc = json['weather'],
        weatherPrimaryTitle = json['weatherPrimary'],
        sunrise = json['sunrise'],
        sunset = json['sunset'],
        icon = MasterUri.storageUrl.storage + json['icon'];
}
