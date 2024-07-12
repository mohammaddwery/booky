import 'package:flutter/material.dart';
import 'books_results_listing.dart';

class BooksSearchResults extends StatelessWidget {
  const BooksSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: BooksResultsListing());
  }
}


