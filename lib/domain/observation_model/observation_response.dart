import 'observation_model.dart';

class ObservationWeatherResponse {
  final List<ObservationWeatherModel> list;

  ObservationWeatherResponse({
    required this.list,
  });

  factory ObservationWeatherResponse.fromJson(List<dynamic> parsedJson) {
    List<ObservationWeatherModel> list = <ObservationWeatherModel>[];
    list =
        parsedJson.map((i) => ObservationWeatherModel.fromJsonMap(i)).toList();

    return ObservationWeatherResponse(list: list);
  }
}
