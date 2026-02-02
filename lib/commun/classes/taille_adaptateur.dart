import 'package:flutter/material.dart';

class TailleAdaptateur {
  static int heightRef = 914;
  static int widthRef = 411;

  static double width(BuildContext context, double value) {
    final widthTel = MediaQuery.of(context).size.width;
    return value * widthTel / widthRef;
  }

  static double height(BuildContext context, double value) {
    final heightTel = MediaQuery.of(context).size.height;
    return value * heightTel / heightRef;
  }

  static double font(BuildContext context, double value) {
    final coeff = MediaQuery.of(context).size.width / widthRef;
    return (value * coeff).clamp(value * 0.85, value * 1.2);
  }
}
