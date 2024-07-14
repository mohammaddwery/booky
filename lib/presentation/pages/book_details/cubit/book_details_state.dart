import 'package:booky/data/models/book.dart';
import 'package:equatable/equatable.dart';

sealed class BookDetailsState extends Equatable {
  const BookDetailsState();

  @override
  List<Object> get props => [];
}

final class BookLoading extends BookDetailsState {}

final class BookSuccess extends BookDetailsState {
const BookSuccess(this.book);
final Book book;

@override
List<Object> get props => [ book ];

@override
bool? get stringify => true;
}

final class BookError extends BookDetailsState {
const BookError(this.error);

final String error;

@override
List<Object> get props => [ error ];
}
