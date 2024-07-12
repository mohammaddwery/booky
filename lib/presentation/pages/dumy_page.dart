import 'package:auto_route/auto_route.dart';
import 'package:booky/presentation/pages/home/widgets/book_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: BookCard()),
    );
  }
}
