import 'package:flutter/material.dart';
import 'custom_error.dart';

class NoResultsPlaceholder extends StatelessWidget {
  const NoResultsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomError(message: 'Sorry no results found!!'));
  }
}