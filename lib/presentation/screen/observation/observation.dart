import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:volantisassignmenttoaditya/presentation/widget/utils/primary_button.dart';

import '../../../data/provider/forcast_provider.dart';
import '../../../data/provider/observation_provider.dart';
import '../../../data/provider/weather_provider.dart';
import '../../widget/loading.dart';
import '../../widget/weather/weather_observation_widget.dart';

class ObservationScreen extends ConsumerStatefulWidget {
  const ObservationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ObservationScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends ConsumerState<ObservationScreen> {
  int oldLength = 0;
  bool isSearchActived = false;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(observationProvider).isLoading;
    final weathers = ref.watch(stateSearchobservationModel.notifier).state;
    TextEditingController country = TextEditingController();
    TextEditingController state = TextEditingController();
    TextEditingController city = TextEditingController();

    return Consumer(
      builder: (ctx, watch, child) {
        oldLength = weathers.length;
        // init data or error
        if (weathers.isEmpty) {
          // error case
          if (isLoading == false) {
            return const Center(
              child: Text('Data tidak ditemukan'),
            );
          }
          return const LoadingProgress(
            loadingColor: Colors.black,
          );
        }
        return RefreshIndicator(
            onRefresh: () {
              return ref.read(observationProvider.notifier).refresh();
            },
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.black,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearchActived = true;
                            });
                          },
                          child: const Icon(Icons.search)),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            ref.read(observationProvider.notifier).refreshGPS();
                            const snackBar = SnackBar(
                              content: Text('Success refresh GPS'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: const Icon(Icons.gps_fixed)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                isSearchActived == true
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: CountryStateCityPicker(
                              country: country,
                              state: state,
                              city: city,
                              textFieldInputBorder:
                                  const UnderlineInputBorder(),
                            ),
                          ),
                          PrimaryButton(
                              onpressed: () async {
                                debugPrint(
                                    "starting find data with country && city");
                                // ignore: no_leading_underscores_for_local_identifiers
                                String _city = city.text;
                                // ignore: no_leading_underscores_for_local_identifiers
                                String _country = country.text;
                                ref
                                    .read(observationProvider.notifier)
                                    .getCountryObservation(_country, _city);
                                ref
                                    .read(forcastProvider.notifier)
                                    .getCountryForcast(_country, _city);
                                ref
                                    .read(weatherProvider.notifier)
                                    .getCountryWeather(_country, _city);
                                final snackBar = SnackBar(
                                  content: Text('$_city is found'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                setState(() {
                                  isSearchActived = false;
                                });
                              },
                              textLabel: "Find"),
                        ],
                      )
                    : Container(),
                const Divider(),
                const Text("Current Condition",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      //  height: 1.4,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    )),
                const Divider(),
                ObservationWeatherWidget(
                  weather: weathers,
                ),
              ],
            ));
      },
    );
  }
}
