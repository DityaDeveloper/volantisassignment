import 'package:flutter/material.dart';

import '../../../application/app_color_constant.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.onpressed, required this.textLabel})
      : super(key: key);
  final void Function()? onpressed;
  final String textLabel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.backgroundColour),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: AppColor.backgroundColour)))),
      onPressed: onpressed,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          textLabel,
          style: const TextStyle(fontSize: 14, color: AppColor.textWhiteColor),
        ),
      ),
    );
  }
}
