import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:volantisassignmenttoaditya/data/repo/shared_pref.dart';
import 'package:volantisassignmenttoaditya/domain/observation_model/observation_model.dart';

class ObservationWeatherWidget extends StatefulWidget {
  const ObservationWeatherWidget({Key? key, required this.weather})
      : super(key: key);

  final List<ObservationWeatherModel> weather;

  @override
  State<ObservationWeatherWidget> createState() =>
      _ObservationWeatherWidgetState();
}

class _ObservationWeatherWidgetState extends State<ObservationWeatherWidget> {
  late String currentAddress;

  @override
  void initState() {
    loadAddress();
    super.initState();
  }

  loadAddress() async {
    await DityaSharedPreferences.instance
        .getStringValue("currentaddress")
        .then((value) => currentAddress = value!);
    debugPrint("get location address $currentAddress");
  }

  @override
  Widget build(BuildContext context) {
    return _buildObservationWeatherWidget(widget.weather);
  }

  Widget _buildObservationWeatherWidget(List<ObservationWeatherModel> weather) {
    var screenSize = MediaQuery.of(context).size;
    var defaultPadding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

    return Container(
      //height: 120,
      height: screenSize.height * 0.55,
      width: screenSize.width,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          var currentDate = DateTime.now();
          var d24 = DateFormat('HH').format(currentDate);
          var m60 = DateFormat('mm').format(currentDate);
          var s60 = DateFormat('ss').format(currentDate);
          // sunset
          var sunsetTimer =
              DateTime.fromMillisecondsSinceEpoch(weather[index].sunset * 1000);
          var ss24h = DateFormat('HH').format(sunsetTimer);
          var ss60m = DateFormat('mm').format(sunsetTimer);
          var ss60s = DateFormat('ss').format(sunsetTimer);
          // sunrise
          var sunriseTimer = DateTime.fromMillisecondsSinceEpoch(
              weather[index].sunrise * 1000);
          var sr24h = DateFormat('HH').format(sunriseTimer);
          var sr60m = DateFormat('mm').format(sunriseTimer);
          var sr60s = DateFormat('ss').format(sunriseTimer);
          // to sunset
          int? sunsetHours = int.tryParse(ss24h)! - int.tryParse(d24)!;
          int? sunsetMinutes = int.tryParse(ss60m)! - int.tryParse(m60)!;
          int? sunsetSecond = int.tryParse(ss60s)! - int.tryParse(s60)!;
          // to sunrise
          int? sunriseHours = int.tryParse(sr24h)! - int.tryParse(d24)!;
          int? sunriseMinutes = int.tryParse(sr60m)! - int.tryParse(m60)!;
          int? sunriseSecond = int.tryParse(sr60s)! - int.tryParse(s60)!;
          debugPrint(
              "sunset hours : $sunsetHours - sunset minutes : $sunsetMinutes - sunset second : $sunsetSecond");
          debugPrint(
              "sunrise hours : $sunriseHours - sunrise minutes : $sunriseMinutes - sunrise second : $sunriseSecond");

          return GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenSize.width,
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
                        Row(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '${weather[index].tempCelcius}°',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    //  height: 1.4,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      widget.weather[index].icon,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenSize.width,
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
                        SizedBox(
                          width: screenSize.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Humadity : ${weather[index].humidity.toString()}%",
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
                        SizedBox(
                          width: screenSize.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Feels like : ${weather[index].tempCelcius.toString()}°",
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
                        SizedBox(
                          width: screenSize.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Pressure : ${weather[index].pressureMB.toString()}MB",
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
                        SizedBox(
                          width: screenSize.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Wind Speed : ${weather[index].windspeedKPH.toString()}/KPH",
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
                        Column(
                          children: [
                            SizedBox(
                              width: screenSize.width,
                              child: const Card(
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Sunrise start in :",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      //  height: 1.4,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SlideCountdown(
                              duration: Duration(
                                hours: sunriseHours,
                                minutes: sunriseMinutes,
                                seconds: sunriseSecond,
                              ),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: screenSize.width,
                              child: const Card(
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Sunset start on :",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      //  height: 1.4,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SlideCountdown(
                              duration: Duration(
                                  hours: sunsetHours,
                                  minutes: sunsetMinutes,
                                  seconds: sunsetSecond),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            // SlideCountdown(
                            //   duration: Duration(
                            //       milliseconds: weather[index].sunset ~/ 100),
                            //   padding: defaultPadding,
                            //   separatorType: SeparatorType.title,
                            //   durationTitle: DurationTitle.id(),
                            //   icon: const Padding(
                            //     padding: EdgeInsets.only(right: 5),
                            //     child: Icon(
                            //       Icons.alarm,
                            //       color: Colors.white,
                            //       size: 20,
                            //     ),
                            //   ),
                            //   decoration: const BoxDecoration(
                            //     color: Colors.black,
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(5)),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )));
        },
      ),
    );
  }
}
