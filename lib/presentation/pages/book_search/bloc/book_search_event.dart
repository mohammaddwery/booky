import 'package:equatable/equatable.dart';

sealed class BookSearchEvent extends Equatable {
  const BookSearchEvent();
}

final class KeywordChanged extends BookSearchEvent {
  const KeywordChanged({this.keyword=''});
  final String keyword;

  @override
  List<Object> get props => [keyword];

  @override
  bool? get stringify => true;
}

final class BooksRequested extends BookSearchEvent {
  const BooksRequested();
  @override
  List<Object> get props => [];
}
