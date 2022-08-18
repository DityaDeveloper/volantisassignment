import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../domain/weather_model/weather_model.dart';

class CircularCountdownWidget extends StatefulWidget {
  const CircularCountdownWidget({Key? key, required this.weather})
      : super(key: key);

  final WeatherModel weather;

  @override
  State<CircularCountdownWidget> createState() =>
      _CircularCountdownWidgetState();
}

class _CircularCountdownWidgetState extends State<CircularCountdownWidget> {
  var defaultPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Space"),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('Localization Custom Duration Title'),
            ),
            SlideCountdown(
              duration: Duration(microseconds: widget.weather.timestamp),
              padding: defaultPadding,
              separatorType: SeparatorType.title,
              durationTitle: DurationTitle.id(),
              icon: const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.alarm,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
