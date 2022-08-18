import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volantisassignmenttoaditya/presentation/widget/weather/weather_forcast_widget.dart';

import '../../../data/provider/forcast_provider.dart';

import '../../widget/loading.dart';

class ForecastScreen extends ConsumerStatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends ConsumerState<ForecastScreen> {
  int oldLength = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, watch, child) {
        final isLoading = ref.watch(forcastProvider).isLoading;
        final blogs = ref.watch(forcastSearchProvider.notifier).state;

        oldLength = blogs.length;
        // init data or error
        if (blogs.isEmpty) {
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
              return ref.read(forcastProvider.notifier).refresh();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text("Forcast 7days",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        //  height: 1.4,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
                const Divider(),
                ForcastWeatherWidget(
                  weather: blogs,
                ),
              ],
            ));
      },
    );
  }
}
