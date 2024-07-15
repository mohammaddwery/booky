import 'package:booky/data/models/user_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/books_repository.dart';
import 'upsert_book_event.dart';
import 'upsert_book_state.dart';

class UpsertBookBloc extends Bloc<UpsertBookEvent, UpsertBookState> {
  final BooksRepository _booksRepository;
  UpsertBookBloc(this._booksRepository, [UserBook? book]): super(UpsertBookState(
    author: book?.author,
    title: book?.title,
    description: book?.description,
    publish: book?.publish,
  )) {
    on<UpdateBookRequested>(_onUpdateBookRequested,);
    on<AddBookRequested>(_onAddBookRequested,);
    on<BookTitleChanged>(_onBookTitleChanged,);
    on<BookAuthorChanged>(_onBookAuthorChanged,);
    on<BookDescriptionChanged>(_onBookDescriptionChanged,);
    on<BookPublishDateChanged>(_onBookPublishDateChanged,);
  }

  Future<void> _onAddBookRequested(AddBookRequested event, Emitter<UpsertBookState> emit,) async {
    String? validationMessage = _validateInputs();
    if(validationMessage!=null) {
      return emit(UpsertBookFailure(
        validationMessage,
        DateTime.now().millisecond,
        state.title,
        state.author,
        state.description,
        state.publish,
      ));
    }

    _booksRepository.addUserBook(UserBook(
      id: DateTime.now().millisecond,
      author: state.author!,
      title: state.title!,
      description: state.description!,
      publish: state.publish!,
    ));
    emit(AddBookSuccess());
  }

  Future<void> _onUpdateBookRequested(UpdateBookRequested event, Emitter<UpsertBookState> emit,) async {
    String? validationMessage = _validateInputs();
    if(validationMessage!=null) {
      return emit(UpsertBookFailure(
        validationMessage,
        DateTime.now().millisecond,
        state.title,
        state.author,
        state.description,
        state.publish,
      ));
    }
    final userBook = _booksRepository.updateUserBook(
      bookId: event.bookId,
      book: UserBook(
        id: DateTime.now().millisecond,
        author: state.author!,
        title: state.title!,
        description: state.description!,
        publish: state.publish!,
      ),
    );
    emit(UpdateBookSuccess(userBook.id));
  }

  Future<void> _onBookTitleChanged(BookTitleChanged event, Emitter<UpsertBookState> emit,) async {
    emit(UpsertBookState(
        title: event.value,
        author: state.author,
        description: state.description,
        publish: state.publish,
    ));
  }

  Future<void> _onBookAuthorChanged(BookAuthorChanged event, Emitter<UpsertBookState> emit,) async {
    emit(UpsertBookState(
      title: state.title,
      author: event.value,
      description: state.description,
      publish: state.publish,
    ));
  }

  Future<void> _onBookDescriptionChanged(BookDescriptionChanged event, Emitter<UpsertBookState> emit,) async {
    emit(UpsertBookState(
      title: state.title,
      author: state.author,
      description: event.value,
      publish: state.publish,
    ));
  }

  Future<void> _onBookPublishDateChanged(BookPublishDateChanged event, Emitter<UpsertBookState> emit,) async {
    emit(UpsertBookState(
      title: state.title,
      author: state.author,
      description: state.description,
      publish: event.value,
    ));
  }

  String? _validateInputs() {
    /// Title's validation
    if (state.title?.isEmpty ?? true) {
      return 'Please enter your book\'s title';
    }

    if (state.title!.length < 10 || state.title!.length > 120) {
      return 'Please keep your book\'s title between 10 and 120 characters';
    }

    /// Author's validation
    if (state.author?.isEmpty ?? true) {
      return 'Please enter your book\'s author name';
    }

    if (state.author!.length < 10 || state.author!.length > 32) {
      return 'Please keep your book\'s author name between 10 and 32 characters';
    }

    /// Description's validation
    if (state.description?.isEmpty ?? true) {
      return 'Please enter your book\'s description';
    }

    if (state.description!.length < 20 || state.description!.length > 400) {
      return 'Please keep your book\'s description between 20 and 200 characters';
    }

    /// Publish date validation
    if (state.publish == null) {
      return 'Please enter your book\'s publish date';
    }

    if (state.publish!.isBefore(DateTime(2000))) {
      return 'Sorry your book has to beb published after 2000';
    }

    return null;
  }
}