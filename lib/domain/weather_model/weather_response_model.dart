import 'weather_model.dart';

class WeatherResponse {
  final List<WeatherModel> list;

  WeatherResponse({
    required this.list,
  });

  factory WeatherResponse.fromJson(List<dynamic> parsedJson) {
    List<WeatherModel> list = <WeatherModel>[];
    list = parsedJson.map((i) => WeatherModel.fromJsonMap(i)).toList();

    return WeatherResponse(list: list);
  }
}
