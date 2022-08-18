import 'forcast_weather_model.dart';

class ForcastWeatherResponse {
  final List<ForcastWeatherModel> list;

  ForcastWeatherResponse({
    required this.list,
  });

  factory ForcastWeatherResponse.fromJson(List<dynamic> parsedJson) {
    List<ForcastWeatherModel> list = <ForcastWeatherModel>[];
    list = parsedJson.map((i) => ForcastWeatherModel.fromJsonMap(i)).toList();

    return ForcastWeatherResponse(list: list);
  }
}
