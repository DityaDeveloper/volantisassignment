import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: unused_element
class LoadingProgress extends StatelessWidget {
  final Color? loadingColor;

  // ignore: use_key_in_widget_constructors
  const LoadingProgress({
    required this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.moving,
              size: 20,
              color: loadingColor ?? Colors.transparent,
            ),
          ),
          SpinKitRing(
            color: loadingColor ?? Colors.transparent,
            size: 50,
            lineWidth: 2.0,
          ),
        ],
      ),
    );
  }
}
