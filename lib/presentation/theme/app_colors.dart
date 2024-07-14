import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF803C70);
  static const Color secondary = Color(0xFF522F65);
  static const Color accent = Color(0xFFFBF4F9);

  static Color get primary60 => primary.withOpacity(.6);
  static Color get primary15 => primary.withOpacity(.15);
  static const Color error = Colors.redAccent;
  static Color grey90 = Colors.grey.shade900;
  static Color grey30 = Colors.grey.shade300;

}