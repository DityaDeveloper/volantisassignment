import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volantisassignmenttoaditya/domain/forcast_weather_model/forcast_weather_model.dart';
import 'package:volantisassignmenttoaditya/domain/weather_model/weather_model.dart';

class ConditionWeatherWidget extends StatefulWidget {
  const ConditionWeatherWidget({Key? key, required this.weather})
      : super(key: key);

  final List<WeatherModel> weather;

  @override
  State<ConditionWeatherWidget> createState() => _ConditionWeatherWidgetState();
}

class _ConditionWeatherWidgetState extends State<ConditionWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildConditionWeatherWidget(widget.weather);
  }

  Widget _buildConditionWeatherWidget(List<WeatherModel> weather) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      height: 150,

      //height: screenSize.height * 0.7,
      width: screenSize.width,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: weather.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                debugPrint("testing");
              },
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${widget.weather[index].tempCelcius}°',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                // height: 1.4,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.weather[index].icon,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.4,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                DateFormat('HH:mm').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        weather[index].timestamp * 1000)),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  // height: 1.4,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.4,
                          child: Card(
                            color: const Color.fromARGB(255, 211, 212, 212),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                weather[index].weatherPrimaryTitle,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  //  height: 1.4,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
        },
      ),
    );
  }
}
