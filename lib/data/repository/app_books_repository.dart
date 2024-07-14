import 'package:booky/repository/books_repository.dart';
import '../../repository/user_book.dart';
import '../models/book.dart';

class AppBooksRepository extends BooksRepository {
  AppBooksRepository(super.apiProvider, super.storeProvider,);

  final List<UserBook> _myRunTimeBooks = [];

  /// Remote resources functionalities
  @override
  Future<List<Book>> getBooks() => apiProvider.getBooks();

  @override
  Future<Book> getBook(String workId) => apiProvider.getBook(workId);


  /// Local resources functionalities
  @override
  Future addFavoriteBook(String workId) => storeProvider.addFavoriteBook(workId);

  @override
  Future<List<String>> addFavoriteBooks(List<String> workIds) => storeProvider.addFavoriteBooks(workIds);

  @override
  List<String> getFavoriteBooks() => storeProvider.getFavoriteBooks();

  @override
  Future removeFavoriteBook(String workId) => storeProvider.removeFavoriteBook(workId);

  @override
  List<UserBook> addUserBook(UserBook book) {
    _myRunTimeBooks.insert(0, book);
    final books =  getUserBooks();
    print('addUserBook() ${books.length}');

    return books;
  }

  @override
  List<UserBook> getUserBooks() {
    print('getUserBooks() ${_myRunTimeBooks.length}');
    return _myRunTimeBooks;
  }
}