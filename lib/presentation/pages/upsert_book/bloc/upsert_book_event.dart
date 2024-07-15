import 'package:equatable/equatable.dart';

import '../../../../data/models/user_book.dart';

sealed class UpsertBookEvent extends Equatable {
  const UpsertBookEvent();
}

final class UpdateBookRequested extends UpsertBookEvent {
  final int bookId;
  final UserBook userBook;
  const UpdateBookRequested(this.bookId, this.userBook,);
  @override
  List<Object> get props => [ bookId, userBook ];
}

final class AddBookRequested extends UpsertBookEvent {
  final UserBook userBook;
  const AddBookRequested(this.userBook,);
  @override
  List<Object?> get props => [ userBook ];
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
