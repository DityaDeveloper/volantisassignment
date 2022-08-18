import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volantisassignmenttoaditya/domain/forcast_weather_model/forcast_weather_model.dart';
import 'package:volantisassignmenttoaditya/domain/weather_model/weather_model.dart';

import '../utils/circular_countdown_widget.dart';

class ForcastWeatherWidget extends StatefulWidget {
  const ForcastWeatherWidget({Key? key, required this.weather})
      : super(key: key);

  final List<ForcastWeatherModel> weather;

  @override
  State<ForcastWeatherWidget> createState() => _ForcastWeatherWidgetState();
}

class _ForcastWeatherWidgetState extends State<ForcastWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildForcastWeatherWidget(widget.weather);
  }

  Widget _buildForcastWeatherWidget(List<ForcastWeatherModel> weather) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      //height: 120,
      height: screenSize.height * 0.6,
      width: screenSize.width,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: weather.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                debugPrint("testing");
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => CircularCountdownWidget(
                //           weather: weather[index],
                //         )));
              },
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: Row(
                      children: [
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
                                DateFormat('EEE, dd/MM/yyyy').format(
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
