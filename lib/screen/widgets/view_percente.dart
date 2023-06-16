import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../controllers/app_controler.dart';

class ViewPercente extends StatefulWidget {
  ViewPercente({
    Key? key,
  }) : super(key: key);

  @override
  _ViewPercenteState createState() => _ViewPercenteState();
}

class _ViewPercenteState extends State<ViewPercente> {
  final appController = Get.put(AppControler());
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      backgroundWidth: 30,
      startAngle: 180,
      radius: 100.0,
      lineWidth: 16.0,
      animation: false,
      percent: appController.percentageMusic.value / 100,
      center: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: "${appController.percentageMusic.value} % \n",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white),
            ),
            TextSpan(
                text: (appController.isPlaying.value == false)
                    ? 'En cours'
                    : 'Terminée',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white)),
          ],
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.green,
      backgroundColor: Colors.white,
    );
  }
}
