import 'package:booky/repository/books_repository.dart';
import '../models/book.dart';

class AppBooksRepository extends BooksRepository {
  AppBooksRepository(super.apiProvider, super.storeProvider,);

  /// Remote resources functionalities
  @override
  Future<List<Book>> getBooks() => apiProvider.getBooks();

  @override
  Future<Book> getBook(String workId) => apiProvider.getBook(workId);


  /// Local resources functionalities
  @override
  Future<List<String>> addFavoriteBook(String workId) => storeProvider.addFavoriteBook(workId);

  @override
  Future<List<String>> addFavoriteBooks(List<String> workIds) => storeProvider.addFavoriteBooks(workIds);

  @override
  List<String> getFavoriteBooks() => storeProvider.getFavoriteBooks();

  @override
  Future removeFavoriteBook(String workId) => storeProvider.removeFavoriteBook(workId);
}