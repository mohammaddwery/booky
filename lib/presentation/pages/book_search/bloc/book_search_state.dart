import 'package:booky/data/models/book.dart';
import 'package:equatable/equatable.dart';

sealed class BookSearchState extends Equatable {
  const BookSearchState();

  @override
  List<Object> get props => [];
}

final class SearchStateEmpty extends BookSearchState {}

final class SearchStateLoading extends BookSearchState {}

final class SearchStateSuccess extends BookSearchState {
  const SearchStateSuccess(this.books);
  final List<Book> books;

  @override
  List<Object> get props => [ books ];

  @override
  bool? get stringify => true;
}

final class SearchStateError extends BookSearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [ error ];
}
