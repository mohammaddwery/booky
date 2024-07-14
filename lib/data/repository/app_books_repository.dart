import 'package:booky/repository/books_repository.dart';
import '../models/user_book.dart';
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
  UserBook addUserBook(UserBook book) {
    _myRunTimeBooks.insert(0, book);
    return getUserBooks().first;
  }

  @override
  List<UserBook> getUserBooks() {
    return List<UserBook>.from(_myRunTimeBooks);
  }

  @override
  UserBook updateUserBook({required int bookId, required UserBook book}) {
    removeUserBook(bookId);
    return addUserBook(book);
  }

  @override
  void removeUserBook(int id) {
    _myRunTimeBooks.removeWhere((element) => element.id == id);
  }
}