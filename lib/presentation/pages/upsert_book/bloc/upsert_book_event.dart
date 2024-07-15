import 'package:equatable/equatable.dart';

sealed class UpsertBookEvent extends Equatable {
  const UpsertBookEvent();
}

final class UpdateBookRequested extends UpsertBookEvent {
  final int bookId;
  const UpdateBookRequested(this.bookId,);
  @override
  List<Object> get props => [ bookId ];
}

final class AddBookRequested extends UpsertBookEvent {
  const AddBookRequested();
  @override
  List<Object> get props => [ ];
}

final class BookTitleChanged extends UpsertBookEvent {
  final String? value;
  const BookTitleChanged(this.value);
  @override
  List<Object?> get props => [ value ];
}

final class BookAuthorChanged extends UpsertBookEvent {
  final String? value;
  const BookAuthorChanged(this.value);
  @override
  List<Object?> get props => [ value ];
}

final class BookDescriptionChanged extends UpsertBookEvent {
  final String? value;
  const BookDescriptionChanged(this.value);
  @override
  List<Object?> get props => [ value ];
}

final class BookPublishDateChanged extends UpsertBookEvent {
  final DateTime? value;
  const BookPublishDateChanged(this.value);
  @override
  List<Object?> get props => [ value ];
}
