import 'package:flutter/material.dart';

String uri = 'http://192.168.100.10:3000/api';

class GlobalVariables {
  // Colors
  static const appBarGradient = LinearGradient(
    colors: [
      Color(0xff480048),
      Color(0xffC04848),
    ],
    stops: [0.5, 1.0],
  );

  static const primaryColor = Color(0xff480048);
  static const secondaryColor = Color(0xffC04848);
  static const greyColor = Color.fromARGB(255, 172, 172, 172);
  static const backgroundColor = Colors.white;
}
