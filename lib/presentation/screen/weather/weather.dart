import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/provider/weather_provider.dart';
import '../../widget/loading.dart';
import '../../widget/weather/weather_condition_widget.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  int oldLength = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, watch, child) {
        final isLoading = ref.watch(weatherProvider).isLoading;
        final weathers = ref.watch(stateSearchWeatherModel.notifier).state;

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
              return ref.read(weatherProvider.notifier).refresh();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text("Condition per hours",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        //  height: 1.4,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
                const Divider(),
                ConditionWeatherWidget(
                  weather: weathers,
                ),
              ],
            ));
      },
    );
  }
}
