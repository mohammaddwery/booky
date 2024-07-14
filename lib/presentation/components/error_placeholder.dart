import 'package:flutter/material.dart';
import '../theme/text_style.dart';
import 'custom_error.dart';

class ErrorPlaceholder extends StatelessWidget {
  final String message;
  final VoidCallback onRetryClicked;
  const ErrorPlaceholder({required this.message, required this.onRetryClicked, super.key,});

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomError(
      message: message,
      textStyle: AppTextStyle.errorStateStyle,
      onRetryClicked: onRetryClicked,
    ));
  }
}