import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF803C70);
  static const Color secondary = Color(0xFF522F65);
  static const Color accent = Color(0xFFFBF4F9);

  static Color get primary60 => primary.withOpacity(.6);

}